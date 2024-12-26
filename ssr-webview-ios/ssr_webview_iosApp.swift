//
//  ssr_webview_iosApp.swift
//  ssr-webview-ios
//
//  Created by Orhan Aytekin on 26.12.2024.
//

import SwiftUI

@main
struct ssr_webview_iosApp: App {
    init() {
        // Print bundle information on startup
        print("App Bundle Path: \(Bundle.main.bundlePath)")
        if let resources = Bundle.main.urls(forResourcesWithExtension: "html", subdirectory: nil) {
            print("Found HTML files:")
            resources.forEach { print("  - \($0.lastPathComponent)") }
        } else {
            print("⚠️ No HTML files found in bundle")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
