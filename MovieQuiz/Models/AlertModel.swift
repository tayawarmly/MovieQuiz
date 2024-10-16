//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Taya on 14.09.2024.
//

import UIKit

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    
    var completion: () -> Void
}
