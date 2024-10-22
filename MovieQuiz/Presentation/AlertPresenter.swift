//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Taya on 14.09.2024.
//

import UIKit

class AlertPresenter {
    weak var viewController: MovieQuizViewController?
    
    init(viewController: MovieQuizViewController?) {
        self.viewController = viewController
    }
    
    func presentAlert(quiz result: AlertModel) {
        
        let alert = UIAlertController(
            title: result.title,
            message: result.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(
            title: result.buttonText,
            style: .default) { [weak self] _ in
                guard let self = self else { return }
                result.completion()
            }
        alert.addAction(action)
        alert.view.accessibilityIdentifier = "Alert"
        viewController?.present(alert, animated: true, completion: nil)
        
    }
}
