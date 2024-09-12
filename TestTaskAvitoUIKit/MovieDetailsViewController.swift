//
//  PhotoDetailsViewController.swift
//  TestTaskAvitoUIKit
//
//  Created by Denis Dareuskiy on 11.09.24.
//

import Foundation
import UIKit

class PhotoDetailsViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let photoImageView = UIImageView()
    private let favoriteButton = UIButton(type: .system)
    
    private let descriptionLabel = UILabel()
    
    private var photo: UnsplashPhoto // Добавляем фото
    private var favorites: [UnsplashPhoto] = [] // Массив для хранения избранных фотографий

    init(photo: UnsplashPhoto) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupScrollView()
        setupPhotoImageView()
        setupLabels()
        setupFavoriteButton()
        
        loadPhotoImage()
        setupLayout()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupPhotoImageView() {
        photoImageView.layer.cornerRadius = 10
        photoImageView.clipsToBounds = true
        contentView.addSubview(photoImageView)
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 250),
            photoImageView.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        // Установка начального изображения-плейсхолдера
        photoImageView.image = UIImage(systemName: "photo")
    }
    
    private func setupLabels() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupFavoriteButton() {
        favoriteButton.addTarget(self, action: #selector(toggleFavoritePhoto), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
        updateFavoriteButton()
    }
    
    private func loadPhotoImage() {
        let imageUrlString = photo.urls.small // Предполагается, что это строка

        if let imageUrl = URL(string: imageUrlString) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.photoImageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.photoImageView.image = UIImage(named: "placeholder") // Установка плейсхолдера на случай ошибки
                    }
                }
            }
        } else {
            print("Invalid URL string: \(imageUrlString)")
            photoImageView.image = UIImage(named: "placeholder") // Установка плейсхолдера на случай недопустимого URL
        }
    }
    
    private func updateFavoriteButton() {
        let favoriteImage = favorites.contains(where: { $0.id == photo.id }) ? "star.fill" : "star"
        favoriteButton.setImage(UIImage(systemName: favoriteImage), for: .normal)
    }
    
    @objc private func toggleFavoritePhoto() {
        if let index = favorites.firstIndex(where: { $0.id == photo.id }) {
            favorites.remove(at: index) // Удалить из избранного
        } else {
            favorites.append(photo) // Добавить в избранное
        }
        updateFavoriteButton()
    }
    
    private func setupLayout() {
        descriptionLabel.text = photo.description
        
        // Layout constraints for descriptionLabel
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
