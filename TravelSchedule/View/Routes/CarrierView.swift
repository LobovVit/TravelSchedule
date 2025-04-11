//
//  CarrierView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 07.04.2025.
//

import SwiftUI

struct CarrierView: View {
    
    @State var carrier: Carrier
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(carrier.logoName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 104)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 24))
            Text("«\(carrier.title)»")
                .font(.system(size: 24, weight: .bold))
                .frame(maxWidth: .infinity, maxHeight: 29, alignment: .leading)
                .padding(.vertical, 16.0)
            VStack(alignment: .leading, spacing: 0) {
                Text("E-mail")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.ypBlackWhite)
                Button {
                    guard let url = URL(string: "mailto:" + carrier.email) else { return }
                    openURL(url)
                } label: {
                    Text("\(carrier.email)")
                        .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.ypBlue)
                }
            }
            .frame(height: 60)
            VStack(alignment: .leading, spacing: 0) {
                Text("Телефон")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.ypBlackWhite)
                Button {
                    guard let url = URL(string: "tel:" + carrier.phone) else { return }
                    openURL(url)
                } label: {
                    Text("\(carrier.phone)")
                        .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.ypBlue)
                }
            }
            .frame(height: 60)
            Spacer()
        }
        .padding(.horizontal, 16.0)
        .navigationTitle("Информация о перевозчике")
    }
}

#Preview {
    CarrierView(carrier: Carrier.sampleData[0])
}
