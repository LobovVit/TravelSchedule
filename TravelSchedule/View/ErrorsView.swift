//
//  ErrorsView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI

enum AppErrorType: Equatable  {
    case noInternet
    case serverError
    case invalidURL
    case timeout
    
    var imageName: String {
        switch self {
        case .serverError: return "error"
        case .noInternet: return "noInternet"
        case .invalidURL: return "noInternet"
        case .timeout: return "noInternet"
        }
    }

    var message: String {
        switch self {
        case .serverError: return "Ошибка сервера"
        case .noInternet: return "Нет интернета"
        case .invalidURL: return "неверный URL"
        case .timeout: return "Превышено время ожидания"
        }
    }
}

struct ErrorView: View {
    let type: AppErrorType

    var body: some View {
        VStack(spacing: 16) {
            Image(type.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)

            Text(type.message)
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    Group {
            ErrorView(type: .serverError)
            ErrorView(type: .noInternet)
            ErrorView(type: .invalidURL)
            ErrorView(type: .timeout)
        }
}
