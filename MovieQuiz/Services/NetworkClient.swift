//
//  NetworkClient.swift
//  MovieQuiz
//
//  Created by Taya on 14.10.2024.
//

import Foundation

/// Отвечает за загрузку данных по URL
struct NetworkClient {

    private enum NetworkError: Error { //реализация протокола error
        case codeError
    }
    
    // загрузка данных по заготовленному url, асинхронная выдача ответа
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url) // создаем запрос из url
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in //обработка ответа
            
            // Проверяем, пришла ли ошибка
            if let error = error {
                handler(.failure(error))
                return
            }
            
            // Проверяем, что нам пришёл успешный код ответа
            if let response = response as? HTTPURLResponse,
                response.statusCode < 200 || response.statusCode >= 300 {
                handler(.failure(NetworkError.codeError))
                return
            }
            
            // Возвращаем данные
            guard let data = data else { return }
            handler(.success(data))
        }
        
        task.resume()
    }
}
