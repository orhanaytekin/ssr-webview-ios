import Foundation

@MainActor
class SolutionViewModel: ObservableObject {
    @Published var htmlContent: String?
    @Published var error: String?
    @Published var isLoading = false
    
    func fetchSolution(path: String) {
        isLoading = true
        error = nil
        
        Task {
            do {
                htmlContent = try await SolutionAPI.fetchSolution(path: path)
            } catch {
                self.error = error.localizedDescription
            }
            isLoading = false
        }
    }
} 