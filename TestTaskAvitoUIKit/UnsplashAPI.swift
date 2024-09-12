//
//  UnsplashAPI.swift
//  TestTaskAvitoUIKit
//
//  Created by Denis Dareuskiy on 10.09.24.
//

import Foundation
// MARK — Service
struct Movie {
    let title: String
    let imageUrl: String
}

struct UnsplashImage: Codable {
    let urls: ImageUrls
}

struct ImageUrls: Codable {
    let small: String
    let regular: String
}

class UnsplashService {
    private let accessKey = "YOUR_ACCESS_KEY" // Замените на ваш API ключ

    func fetchRandomImages(count: Int, completion: @escaping ([String]?) -> Void) {
        let urlString = "https://api.unsplash.com/photos/random?client_id=\(accessKey)&count=\(count)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error: \(response.debugDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received.")
                completion(nil)
                return
            }

            do {
                let imagesResponse = try JSONDecoder().decode([UnsplashImage].self, from: data)
                let imageUrls = imagesResponse.map { $0.urls.small }
                completion(imageUrls)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}

// MARK — Without API call

struct UnsplashPhoto: Identifiable, Codable {
    let id: String
    let urls: PhotoURLs
    let description: String
}

struct PhotoURLs: Codable {
    let small: String
}

let MOCK_DATA: [UnsplashPhoto] = [
    UnsplashPhoto(id: "1", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1521747116042-5a810fda9664"), description: "Титаник"),
    UnsplashPhoto(id: "2", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1521747116042-5a810fda9664"), description: "Звездные войны"),
    UnsplashPhoto(id: "3", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1521747116042-5a810fda9664"), description: "Оно"),
    UnsplashPhoto(id: "4", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1521747116042-5a810fda9664"), description: "Крепкий орешек"),
    UnsplashPhoto(id: "5", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1521747116042-5a810fda9664"), description: "Человек-паук"),
    UnsplashPhoto(id: "6", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1521747116042-5a810fda9664"), description: "Ла-Ла Ленд"),
    UnsplashPhoto(id: "7", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1521747116042-5a810fda9664"), description: "Пираты Карибского моря"),
    UnsplashPhoto(id: "8", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1521747116042-5a810fda9664"), description: "Интерстеллар"),
    UnsplashPhoto(id: "9", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1521747116042-5a810fda9664"), description: "Гладиатор"),
    UnsplashPhoto(id: "10", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1521747116042-5a810fda9664"), description: "Доктор Стрэндж")
]
