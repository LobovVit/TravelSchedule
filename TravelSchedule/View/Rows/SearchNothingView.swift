//
//  SearchNothingView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI

struct SearchNothingView: View {
    
    @State var notification: String
    
    var body: some View {
        Spacer()
        Text(notification)
            .font(.system(size: 24, weight: .bold))
        Spacer()
    }
}

#Preview {
    SearchNothingView(notification: "Пусто")
}
