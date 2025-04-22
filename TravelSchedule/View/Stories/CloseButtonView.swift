//
//  CloseButtonView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 21.04.2025.
//

import SwiftUI

struct CloseButtonView: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle()
                    .foregroundStyle(.ypWhite)
                Image(systemName: "xmark.circle.fill").renderingMode(.template)
                    .resizable()
                    .foregroundStyle(.ypBlack)
            }
            .frame(width: 30.0, height: 30.0)
        }
    }
}

#Preview {
    CloseButtonView{}
}

