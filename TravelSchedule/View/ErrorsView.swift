//
//  ErrorsView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 11.04.2025.
//

import SwiftUI

struct ServerErrorView: View {
    var body: some View {
        Image("error")
        Text("Ошибка сервера")
            .font(.system(size: 24, weight: .bold))
    }
}

struct ConnectionErrorView: View {
    var body: some View {
        Image("noInternet")
        Text("Нет интернета")
            .font(.system(size: 24, weight: .bold))
    }
}

#Preview {
    ConnectionErrorView()
    ServerErrorView()
}
