//
//  AgreementView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI
import Network

struct AgreementView: View {
    
    @State private var isLoading = true
    @State private var loadingProgress: Double = 0.0
    @State private var isLoadingError = false
    let userAgreement = "Пользовательское соглашение"
    let userAgreementURL: String = "https://yandex.ru/legal/practicum_offer/"
    
    var body: some View {
        VStack {
            ProgressView(value: loadingProgress)
                .progressViewStyle(.linear)
                .opacity(loadingProgress == 1.0 ? 0 : 1)
            ZStack {
                WebView(
                    url: userAgreementURL,
                    isLoading: $isLoading,
                    isLoadingError: $isLoadingError,
                    progress: $loadingProgress
                )
                .opacity(isLoadingError ? 0 : 1)
                ProgressView()
                    .opacity(isLoading ? 1 : 0)
                ConnectionErrorView()
                    .opacity(isLoadingError ? 1 : 0)
            }
        }
        .navigationTitle(userAgreement)
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: [.leading, .trailing, .bottom])
        .onAppear {
            isLoading = true
            loadingProgress = 0.0
            isLoadingError = false
        }
    }
}

#Preview {
    AgreementView()
}

