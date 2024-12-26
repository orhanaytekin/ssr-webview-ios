//
//  ContentView.swift
//  ssr-webview-ios
//
//  Created by Orhan Aytekin on 26.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var htmlRecords: [HTMLRecord] = []
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            VStack {
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
                
                List(htmlRecords) { record in
                    NavigationLink(destination: WebViewScreen(htmlContent: record.content)) {
                        Text(record.title)
                    }
                }
            }
            .navigationTitle("HTML Pages")
            .onAppear {
                // Load HTML files
                htmlRecords = HTMLRecord.loadHTMLFiles()
                
                if htmlRecords.isEmpty {
                    errorMessage = "No HTML files found in bundle"
                    
                    // Print debug information
                    print("Debug Info:")
                    print("Bundle URL: \(Bundle.main.bundleURL)")
                    if let resources = Bundle.main.urls(forResourcesWithExtension: nil, subdirectory: nil) {
                        print("All Resources:")
                        resources.forEach { print("  - \($0.lastPathComponent)") }
                    } else {
                        print("No resources found in bundle")
                    }
                } else {
                    errorMessage = nil
                    print("Found \(htmlRecords.count) HTML files")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
