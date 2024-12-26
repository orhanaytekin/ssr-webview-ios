import Foundation

struct HTMLRecord: Identifiable {
    let id = UUID()
    let title: String
    let fileName: String
    
    var content: String {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "html"),
           let content = try? String(contentsOf: url, encoding: .utf8) {
            return content
        }
        print("File not found: \(fileName).html")
        return "Error: File not found"
    }
    
    static func loadHTMLFiles() -> [HTMLRecord] {
        // Get all HTML files from the main bundle
        if let urls = Bundle.main.urls(forResourcesWithExtension: "html", subdirectory: nil) {
            return urls.map { url in
                let fileName = url.deletingPathExtension().lastPathComponent
                let title = fileName.replacingOccurrences(of: "-", with: " ")
                return HTMLRecord(title: title, fileName: fileName)
            }.sorted { $0.title < $1.title }
        }
        
        print("No HTML files found in bundle")
        return []
    }
} 