//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by Taya on 15.09.2024.
//

import UIKit

protocol StatisticServiceProtocol {
    var gamesCount: Int { get }
    var bestGame: GameResult { get } // запись рез-та 1 игры и сохр-е в UserDefaults
    var totalAccuracy: Double { get }
    
    func store(correct count: Int, total amount: Int) //метод для сохранения текущего результата игры
}
