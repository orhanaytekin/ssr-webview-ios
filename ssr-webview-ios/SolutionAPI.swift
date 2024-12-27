import Foundation

struct SolutionResponse: Codable {
    let html: String
}

class SolutionAPI {
    static let baseURL = "url"
    static let token = "token"
    
    static func fetchSolution(path: String) async throws -> String {
        let url = URL(string: "\(baseURL)/solution/v3")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let body = ["path": path]
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(SolutionResponse.self, from: data)
        return response.html
    }
} 