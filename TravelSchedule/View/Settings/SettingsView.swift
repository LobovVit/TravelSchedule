//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var darkMode: Bool
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Toggle("Темная тема", isOn: $darkMode)
                .font(.system(size: 17, weight: .regular))
                .padding(.horizontal, 16.0)
                .frame(maxWidth: .infinity, maxHeight: 60)
                .tint(.ypBlue)
            NavigationLink {
                AgreementView()
            } label: {
                RowSearchView(rowString: "Пользовательское соглашение")
            }
            .font(.system(size: 17, weight: .regular))
            .padding(.horizontal, 16.0)
            .frame(maxWidth: .infinity, maxHeight: 60)

            Spacer()
            
            VStack(alignment: .center, spacing: 16) {
                Text("Приложение использует API «Яндекс.Расписания»")
                Text(viewModel.appVersion)
            }
            .font(.system(size: 12, weight: .regular))
            .frame(minHeight: 44)
        }
        .padding(.vertical, 24.0)
        .foregroundColor(.ypBlackWhite)
        .onAppear { viewModel.loadAppInfo() }
    }
}

#Preview {
        SettingsView(darkMode: .constant(false))
}

