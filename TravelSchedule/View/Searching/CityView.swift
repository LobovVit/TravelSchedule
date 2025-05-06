//
//  CityView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI

struct CityView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var scheduleViewModel: ScheduleViewModel
    @ObservedObject var viewModel: CityViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBarView(searchText: $viewModel.searchString)
            if viewModel.filteredCities.isEmpty && viewModel.state != .loading {
                SearchNothingView(notification: "Город не найден")
            } else {
                ScrollView(.vertical) {
                    LazyVStack(spacing: .zero) {
                        ForEach(viewModel.filteredCities) { city in
                            NavigationLink(value: ViewsRouter.stationView) {
                                RowSearchView(rowString: city.title)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                scheduleViewModel.saveSelected(city: city)
                            })
                            .font(.system(size: 17, weight: .regular))
                            .padding(.horizontal, 16.0)
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .padding(.vertical, 16.0)
                        }
                    }
                }
                .padding(.vertical, 16.0)
            }
            Spacer()
        }
        .navigationTitle("Выбор города")
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
            try? await viewModel.fetchCities()
        }
        .overlay {
            if viewModel.state == .loading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .ypBlackWhite))
            }
        }
    }
    
}

#Preview {
    CityView(scheduleViewModel: ScheduleViewModel(),
             viewModel: CityViewModel(store: [])
    )
}
