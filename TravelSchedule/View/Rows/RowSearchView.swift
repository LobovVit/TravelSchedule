//
//  RowSearchView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI

struct RowSearchView: View {
    
    @State var rowString: String
    
    var body: some View {
        HStack(spacing: 0) {
            Text(rowString)
                .font(.system(size: 17, weight: .regular))
            Spacer()
            Image(systemName: "chevron.forward")
                .imageScale(.large)
        }
    }
}

#Preview {
    RowSearchView(rowString: "Moscow")
}
