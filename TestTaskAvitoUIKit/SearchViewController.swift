//
//  SearchViewController.swift
//  TestTaskAvitoUIKit
//
//  Created by Denis Dareuskiy on 10.09.24.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    private var searchHistory: [String] = []
    private var filteredPhotos: [UnsplashPhoto] = []
    private var isSearchActive: Bool = false
    
    private let collectionView: UICollectionView
    private let searchController: UISearchController

    init() {
        // Настройка UISearchController
        self.searchController = UISearchController(searchResultsController: nil)
        
        // Настройка UICollectionView
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
        
        // Настройка UICollectionView
        collectionView.backgroundColor = .white
        collectionView.register(MovieCellView.self, forCellWithReuseIdentifier: MovieCellView.reuseIdentifier)
        
        // Настройка UISearchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Movies"
        searchController.searchBar.delegate = self // Установка делегата
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Movies"
        
        // Настройка навигации
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Настройка CollectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        // Установка constraints для CollectionView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Инициализация отфильтрованных данных
        filteredPhotos = MOCK_DATA
    }
}

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearchActive ? filteredPhotos.count : MOCK_DATA.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCellView.reuseIdentifier, for: indexPath) as! MovieCellView
        
        // Конфигурируем ячейку с данными
        let photo = isSearchActive ? filteredPhotos[indexPath.item] : MOCK_DATA[indexPath.item]
        cell.configure(with: photo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = isSearchActive ? filteredPhotos[indexPath.item] : MOCK_DATA[indexPath.item]
        let detailsVC = PhotoDetailsViewController(photo: photo) // Предполагается, что у вас есть PhotoDetailsViewController
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // Пустая реализация, так как поиск будет выполняться по Enter
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        // Добавление текста поиска в историю
        searchHistory.append(searchText)
        
        // Фильтрация фотографий
        isSearchActive = true
        filteredPhotos = MOCK_DATA.filter { $0.description.localizedCaseInsensitiveContains(searchText) }
        collectionView.reloadData()
        
        // Закрытие клавиатуры
        searchBar.resignFirstResponder()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let availableWidth = collectionView.frame.width - (padding * 3)
        let width = availableWidth / 2
        return CGSize(width: width, height: 200)
    }
}
