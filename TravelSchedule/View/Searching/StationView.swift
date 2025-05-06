//
//  StationView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI

struct StationView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var scheduleViewModel: ScheduleViewModel
    @ObservedObject var viewModel: StationViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBarView(searchText: $viewModel.searchString)
            if viewModel.filteredStations.isEmpty && viewModel.state != .loading {
                SearchNothingView(notification: "Станция не найдена")
            } else {
                ScrollView(.vertical) {
                    ForEach(viewModel.filteredStations) { station in
                        Button {
                            scheduleViewModel.saveSelected(station: station)
                            scheduleViewModel.navPath.removeAll()
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
        .task {
            viewModel.searchString = String()
            try? await viewModel.fetchStations()
        }
    }
}

#Preview {
    StationView(
        scheduleViewModel: ScheduleViewModel(),
        viewModel: StationViewModel(store: [],city: Mock.citySampleData[0])
    )
}

