//
//  MainSearchView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI

struct MainSearchView: View {
    
    @Binding var schedule: Schedules
    @Binding var navPath: [ViewsRouter]
    @Binding var direction: Int
    private let dummyDirection = ["Откуда", "Куда"]
    
    private var isDepartureReady: Bool {
        !schedule.destinations[0].cityTitle.isEmpty && !schedule.destinations[0].stationTitle.isEmpty
    }

    private var isArrivalReady: Bool {
        !schedule.destinations[1].cityTitle.isEmpty && !schedule.destinations[1].stationTitle.isEmpty
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0 ..< 2) { item in
                    let isCityEmpty = schedule.destinations[item].cityTitle.isEmpty
                    let isStationEmpty = schedule.destinations[item].stationTitle.isEmpty
                    let destinationLabel = isCityEmpty ? dummyDirection[item] : schedule.destinations[item].cityTitle
                    + (isStationEmpty ? "" : " (" + schedule.destinations[item].stationTitle + ")")
                    NavigationLink(value: ViewsRouter.cityView) {
                        HStack {
                            Text(destinationLabel)
                                .foregroundStyle(schedule.destinations[item].cityTitle.isEmpty ? .ypGray : .ypBlack)
                            Spacer()
                        }
                        .padding(16.0)
                        .frame(maxWidth: .infinity, maxHeight: 48)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        direction = item
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
                    (
                        schedule.destinations[0], schedule.destinations[1]
                    ) = (
                        schedule.destinations[1], schedule.destinations[0]
                    )
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

        if isDepartureReady && isArrivalReady {
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
    MainSearchView(schedule: .constant(Schedules.sampleData), navPath: .constant([]), direction: .constant(0))
}

