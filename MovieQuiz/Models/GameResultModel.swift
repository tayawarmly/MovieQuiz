//
//  GameResultModel.swift
//  MovieQuiz
//
//  Created by Taya on 15.09.2024.
//

import UIKit

struct GameResult {
    var correct: Int //количество правильных ответов
    var total: Int //количество вопросов квиза
    var date: Date //дата завершения раунда
    
    func isBetterThan(_ another: Int) -> Bool {
          correct < another
      } //метод сравнения текущей игры с рекордом
}
