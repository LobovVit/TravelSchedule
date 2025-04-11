//
//  RouteView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI

struct RouteView: View {
    
    @State var route: Route
    @State var carrier: Carrier
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                Image(carrier.logoName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 38, height: 38)
                    .padding(.leading, 14)
                HStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        Text(carrier.title)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(.ypBlack)
                        if !route.isDirect {
                            Text("С пересадкой в \(route.connectionStation)")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundStyle(.ypRed)
                        }
                    }
                    Spacer()
                    Text(route.date)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.ypBlack)
                }
            }
            .padding(.top, 14)
            .padding(.trailing, 7)

            HStack(spacing: 0) {
                Text(route.departureTime)
                    .font(.system(size: 17, weight: .regular))
                    .padding(.trailing, 4)
                    .background(.ypLightGray)
                Spacer()
                Text("\(route.durationTime) часов")
                    .font(.system(size: 12, weight: .regular))
                    .padding(.horizontal, 5)
                    .background(.ypLightGray)
                Spacer()
                Text(route.arrivalTime)
                    .font(.system(size: 17, weight: .regular))
                    .padding(.leading, 4)
                    .background(.ypLightGray)
            }
            .background(
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.ypGray)
            )
            .foregroundStyle(.ypBlack)
            .padding(14)
            .frame(maxWidth: .infinity, maxHeight: 48)
        }
        .background(.ypLightGray)
        .frame(maxWidth: .infinity, maxHeight: 104)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    RouteView(route: Schedules.sampleData.routes[0], carrier: Carrier.sampleData[0])
}

