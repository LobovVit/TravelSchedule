//
//  SettingsViewModel.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 29.04.2025.
//

import Foundation
import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var appVersion: String = ""

    func loadAppInfo() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            appVersion = "Версия: " + version
        }
        guard let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else { return }
        appVersion += " (\(build))"
    }
}
