//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Taya on 15.09.2024.
//

import UIKit

// Расширяем при объявлении прямо
final class StatisticService: StatisticServiceProtocol {
    
    private let storage = UserDefaults.standard
    
    enum Keys: String {
        case correct
        case total
        case date
        case bestGame
        case gamesCount //счётчик кол-ва сыгранных игр
        case correctAnswers
        case totalAccuracy  // отношение всех правильных ответов от общего числа вопросов
    }
    
    var gamesCount: Int {
        get {
            storage.integer(forKey: Keys.gamesCount.rawValue)}
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)}
    }
    
    var bestGame: GameResult {
        get {
            // Добавьте чтение значений полей GameResult(correct, total и date) из UserDefaults,
            // затем создайте GameResult от полученных значений
            let correct = storage.integer(forKey: Keys.correct.rawValue)
            let total = storage.integer(forKey: Keys.total.rawValue)
            let date = storage.object(forKey: Keys.date.rawValue) as? Date ?? Date()
            
            return GameResult (
                correct: correct,
                total: total,
                date: date
            )
            
        }
        set {
            // Добавьте запись значений каждого поля из newValue из UserDefaults
            storage.set(newValue.correct, forKey: Keys.correct.rawValue)
            storage.set(newValue.total, forKey: Keys.total.rawValue)
            storage.set(newValue.date, forKey: Keys.date.rawValue)}
    }
    
    private var correctAnswers: Int {
        get {
            storage.integer(forKey: Keys.correctAnswers.rawValue)}
        set {
            storage.setValue(newValue, forKey: Keys.correctAnswers.rawValue)}
    }
    
    var totalAccuracy: Double {
        get {
            storage.double(forKey: Keys.totalAccuracy.rawValue)}
        set {
            storage.set(newValue, forKey: Keys.totalAccuracy.rawValue)}
    }
    
    //сохранение данных
    func store(correct count: Int, total amount: Int) {
        
        correctAnswers += count
        gamesCount += 1
        bestGame.total += amount
        totalAccuracy = Double(correctAnswers) / (Double(gamesCount) * 10) * 100
        
        if bestGame.isBetterThan(count) {
            bestGame.correct = count
            bestGame.date = Date()
        }
    }
}
