//
//  MainSearchView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI

struct MainSearchView: View {
    
    private let dummyDirection = ["Откуда", "Куда"]
    @ObservedObject var scheduleViewModel: ScheduleViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0 ..< 2) { item in
                    let isCityEmpty = scheduleViewModel.destinations[item].city.title.isEmpty
                    let isStationEmpty = scheduleViewModel.destinations[item].station.title.isEmpty
                    let destinationLabel = isCityEmpty ? dummyDirection[item] : scheduleViewModel.destinations[item].city.title
                    + (isStationEmpty ? "" : " (" + scheduleViewModel.destinations[item].station.title + ")")
                    NavigationLink(value: ViewsRouter.cityView) {
                        HStack {
                            Text(destinationLabel)
                                .foregroundStyle(scheduleViewModel.destinations[item].city.title.isEmpty ? .ypGray : .ypBlack)
                            Spacer()
                        }
                        .padding(16.0)
                        .frame(maxWidth: .infinity, maxHeight: 48)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        scheduleViewModel.setDirection(to: item)
                    })
                }
            }
            .background(.ypWhite)
            .clipShape(RoundedRectangle(cornerRadius: 20))

            ZStack {
                Circle()
                    .foregroundColor(.ypWhite)
                    .frame(width: 36)
                Button {
                    scheduleViewModel.swapDestinations()
                } label: {
                    Image(systemName: "arrow.2.squarepath")
                        .foregroundColor(.ypBlue)
                }
            }
        }
        .padding(16.0)
        .background(.ypBlue)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(height: 128)
        .padding(.top, 20.0)
        .padding(.horizontal, 16.0)

        if scheduleViewModel.isSearchButtonReady {
            NavigationLink(value: ViewsRouter.routeView) {
                Text("Найти")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.ypWhite)
                    .frame(width: 150, height: 60)
                    .background(.ypBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(16.0)
            }
        }
        Spacer()
    }
}

#Preview {
    MainSearchView(scheduleViewModel: ScheduleViewModel())
}

