//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Taya on 12.09.2024.
//

import Foundation

protocol QuestionFactoryProtocol {
    var delegate: QuestionFactoryDelegate? { get }
    
    func requestNextQuestion()
    func loadData()
}
