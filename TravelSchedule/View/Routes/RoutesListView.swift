//
//  RoutesListView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI

struct RoutesListView: View {
    
    @StateObject var viewModel: RoutesViewModel
    @ObservedObject var scheduleViewModel: ScheduleViewModel
    
    init(scheduleViewModel: ScheduleViewModel) {
        self.scheduleViewModel = scheduleViewModel
        _viewModel = StateObject(wrappedValue: RoutesViewModel(destinations: scheduleViewModel.destinations ))
    }
    
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .ypBlackWhite))
                    .task {
                        try? await viewModel.searchRoutes()
                    }
            case .none:
                SearchNothingView(notification: "Вариантов нет")
            case .loaded:
                VStack(spacing: 0) {
                    (Text(viewModel.departure) + Text(Image(systemName: "arrow.forward")).baselineOffset(-1) + Text(viewModel.arrival))
                        .font(.system(size: 24, weight: .bold))
                    ScrollView(.vertical) {
                        ForEach(viewModel.filteredRoutes) { route in
                            if let carrier = viewModel.carriers.first(where: { $0.code == route.carrierCode }) {
                                NavigationLink {
                                    CarrierView(carrier: carrier)
                                } label: {
                                    RouteView(route: route, carrier: carrier)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 16.0)
                    
                    Spacer()
                    
                    NavigationLink {
                        FilterView(filter: Binding(
                            get: { viewModel.filter },
                            set: { viewModel.filter = $0 }
                        ))
                    } label: {
                        HStack(alignment: .center, spacing: 4) {
                            Text("Уточнить время")
                                .font(.system(size: 17, weight: .bold))
                            Image(systemName: "circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 8, height: 8)
                                .foregroundColor(viewModel.filter == Filter.fullSearch ? .clear : .ypRed)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .background(.ypBlue)
                        .foregroundStyle(.ypWhite)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding(.horizontal, 16.0)
                .navigationBarTitleDisplayMode(.inline)
            case .error:
                ErrorView(type: viewModel.currentError)
            }
        }
    }
    
}

#Preview {
    RoutesListView(scheduleViewModel: ScheduleViewModel())
}

