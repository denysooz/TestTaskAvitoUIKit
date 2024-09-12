//
//  ViewController.swift
//  TestTaskAvitoUIKit
//
//  Created by Denis Dareuskiy on 9.09.24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let searchVC = SearchViewController()
        let navigationController = UINavigationController(rootViewController: searchVC)
        navigationController.navigationBar.prefersLargeTitles = true
        
        // Настраиваем корневой контроллер
        view.addSubview(navigationController.view)
        addChild(navigationController)
        navigationController.didMove(toParent: self)
    }


}

