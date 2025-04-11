//
//  SearchBarView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    @Environment(\.colorScheme) var colorScheme

    var placeholder = "Введите запрос"
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 17.0, height: 17.0)
                .padding(.horizontal, 8.0)
                .foregroundColor(searchText.isEmpty ? .ypGray : .ypBlackWhite)

            TextField(placeholder, text: $searchText)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.ypBlackWhite)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)

            if !searchText.isEmpty {
                Button {
                    searchText = String()
                    UIApplication.shared.sendAction(
                        #selector(UIResponder.resignFirstResponder),
                        to: nil,
                        from: nil,
                        for: nil
                    )
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 17.0, height: 17.0)
                        .padding(.horizontal, 8.0)
                        .foregroundColor(.ypGray)
                }
            }
        }
        .frame(height: 36)
        .background(colorScheme == .light ? .ypLightGray : .ypGray)
        .cornerRadius(10)
        .padding(.horizontal, 16.0)
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
