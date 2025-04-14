//
//  StationView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI

struct StationView: View {
    
    @Binding var schedule: Schedules
    @Binding var navPath: [ViewsRouter]
    @Binding var direction: Int
    @Environment(\.dismiss) var dismiss
    @State private var searchString = String()

    private var searchingResults: [Station] {
        searchString.isEmpty
            ? schedule.stations
            : schedule.stations.filter { $0.title.lowercased().contains(searchString.lowercased()) }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBarView(searchText: $searchString)
            if searchingResults.isEmpty {
                SearchNothingView(notification: "Станция не найдена")
            } else {
                ScrollView(.vertical) {
                    ForEach(searchingResults) { station in
                        Button {
                            schedule.destinations[direction].stationTitle = station.title
                            navPath.removeAll()
                        } label: {
                            RowSearchView(rowString: station.title)
                        }
                        .font(.system(size: 17, weight: .regular))
                        .padding(.horizontal, 16.0)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .padding(.vertical, 16.0)
                    }
                }
                .padding(.vertical, 16.0)
            }
            Spacer()
        }
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
        .foregroundStyle(.ypBlackWhite)
        .onAppear {
            searchString = String()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .imageScale(.large)
                        .foregroundColor(.ypBlackWhite)
                }
            }
        }
        .contentShape(Rectangle())
        .gesture(
            DragGesture(coordinateSpace: .local)
                .onEnded { value in
                    if value.translation.width > .zero
                        && value.translation.height > -30
                        && value.translation.height < 30 {
                        dismiss()
                    }
                }
        )
    }
}

#Preview {
    StationView(
        schedule: .constant(Mock.schedulesSampleData),
        navPath: .constant([]),
        direction: .constant(0)
    )
}

