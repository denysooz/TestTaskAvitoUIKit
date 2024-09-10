//
//  SearchViewModel.swift
//  TestTaskAvitoUIKit
//
//  Created by Denis Dareuskiy on 10.09.24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var results: [UnsplashPhoto] = []
    
    func searchPhotos(query: String) {
        let apiKey = "YOUR_UNSPLASH_API_KEY"
        let urlString = "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(UnsplashResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
}
