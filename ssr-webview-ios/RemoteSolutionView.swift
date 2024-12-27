import SwiftUI

struct RemoteSolutionView: View {
    @StateObject private var viewModel = SolutionViewModel()
    let path: String
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading solution...")
            } else if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            } else if let html = viewModel.htmlContent {
                WebViewScreen(htmlContent: html)
            } else {
                Text("No content available")
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            viewModel.fetchSolution(path: path)
        }
    }
} 