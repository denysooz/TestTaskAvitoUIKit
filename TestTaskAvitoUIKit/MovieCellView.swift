//
//  HeroCellView.swift
//  TestTaskAvitoUIKit
//
//  Created by Denis Dareuskiy on 11.09.24.
//

import UIKit

class MovieCellView: UICollectionViewCell {
    
    static let reuseIdentifier = "MovieCell"
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(nameLabel)
        
        // Установка constraints для heroImageView
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        // Установка constraints для nameLabel
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    func configure(with photo: UnsplashPhoto) {
        nameLabel.text = photo.description // Установите описание или текст по умолчанию

        // Установка плейсхолдера
        movieImageView.image = UIImage(systemName: "photo") // Установите изображение-плейсхолдер

        // Получаем URL изображения
        let imageUrlString = photo.urls.small // Предполагается, что это всегда строка
        guard let imageUrl = URL(string: imageUrlString) else {
            print("Invalid URL string: \(imageUrlString)")
            return
        }
        
        print("Fetching image from URL: \(imageUrl)") // Отладка URL
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    // Устанавливаем загруженное изображение
                    self?.movieImageView.image = image
                }
            } else {
                print("Failed to load image from URL: \(imageUrl)") // Отладка ошибки
                DispatchQueue.main.async {
                    // Если загрузка не удалась, снова устанавливаем плейсхолдер
                    self?.movieImageView.image = UIImage(named: "placeholder")
                }
            }
        }
    }
}

