//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Taya on 12.09.2024.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)    
}
