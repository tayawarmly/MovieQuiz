//
//  MovieQuizPresenterTests.swift
//  MovieQuizPresenterTests
//
//  Created by Taya on 22.10.2024.
//

import XCTest
@testable import MovieQuiz

final class MovieQuizViewControllerMock: MovieQuizViewControllerProtocol {
    func showLoadingIndicator() {}
    func hideLoadingIndicator() {}
    
    func showNetworkError(message: String) {}
    
    func highlightImageBorder(isCorrectAnswer: Bool) {}
    
    func show(quiz step: QuizStepViewModel) {}
    func show(quiz result: QuizResultViewModel) {}
}

final class MovieQuizPresenterTests: XCTestCase {
    func testPresenterConvertModel() throws {
        let viewControllerMock = MovieQuizViewControllerMock()
        let sut = MovieQuizPresenter(viewController: viewControllerMock)
        
        let emptyData = Data()
        let question = QuizQuestion(image: emptyData, text: "Question Text", correctAnswer: true)
        let viewModel = sut.convert(model: question)
        
        XCTAssertNotNil(viewModel.image)
        XCTAssertEqual(viewModel.question, "Question Text")
        XCTAssertEqual(viewModel.questionNumber, "1/10")
    }
}
