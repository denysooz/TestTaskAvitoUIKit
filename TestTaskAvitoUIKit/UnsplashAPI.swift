//
//  UnsplashAPI.swift
//  TestTaskAvitoUIKit
//
//  Created by Denis Dareuskiy on 10.09.24.
//

import Foundation

struct UnsplashResponse: Codable {
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Identifiable, Codable {
    let id: String
    let urls: PhotoURLs
    let description: String
}

struct PhotoURLs: Codable {
    let small: String
}

let MOCK_DATA: [UnsplashPhoto] = [
    UnsplashPhoto(id: "1", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1513642535796-6b5c2b24a4c0"), description: "Титаник"),
    UnsplashPhoto(id: "2", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0"), description: "Звездные войны"),
    UnsplashPhoto(id: "3", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1517841905240-4729884b3b8e"), description: "Оно"),
    UnsplashPhoto(id: "4", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0"), description: "Крепкий орешек"),
    UnsplashPhoto(id: "5", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1560807708-8cc77767d783"), description: "Человек-паук"),
    UnsplashPhoto(id: "6", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1517841905240-4729884b3b8e"), description: "Ла-Ла Ленд"),
    UnsplashPhoto(id: "7", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0"), description: "Пираты Карибского моря"),
    UnsplashPhoto(id: "8", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1584993421865-89b2d0d6c7c8"), description: "Интерстеллар"),
    UnsplashPhoto(id: "9", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1606291181767-0f9e004c8f79"), description: "Гладиатор"),
    UnsplashPhoto(id: "10", urls: PhotoURLs(small: "https://images.unsplash.com/photo-1517841905240-4729884b3b8e"), description: "Доктор Стрэндж")
]
