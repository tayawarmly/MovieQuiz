//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Taya on 22.10.2024.
//

import Foundation

protocol MovieQuizViewControllerProtocol: AnyObject {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNetworkError(message: String)
    
    func highlightImageBorder(isCorrectAnswer: Bool)
    
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultViewModel)
  
}
