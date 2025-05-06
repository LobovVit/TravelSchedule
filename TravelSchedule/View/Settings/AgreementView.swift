//
//  AgreementView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI
import Network

enum AgreementState: Equatable {
    case loading
    case success
    case error(AppErrorType)
}

@MainActor
struct AgreementView: View {
    
    @State private var loadingProgress: Double = 0.0
    @State private var state: AgreementState = .loading
    let userAgreement = "Пользовательское соглашение"
    let userAgreementURL: String = "https://yandex.ru/legal/practicum_offer/"
    
    var body: some View {
        VStack {
            ProgressView(value: loadingProgress)
                .progressViewStyle(.linear)
                .opacity(loadingProgress == 1.0 ? 0 : 1)
            ZStack {
                switch state {
                case .success,.loading:
                    WebView(
                        url: userAgreementURL,
                        state: $state,
                        progress: $loadingProgress
                    )
                case .error(let errorType):
                    ErrorView(type: errorType)
                }
            }
        }
        .navigationTitle(userAgreement)
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: [.leading, .trailing, .bottom])
        .onAppear {
            loadingProgress = 0.0
        }
    }
}

#Preview {
    AgreementView()
}

