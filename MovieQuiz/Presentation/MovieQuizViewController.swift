import UIKit

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    public let questionsAmount: Int = 10
    private var questionFactory: QuestionFactoryProtocol?
    private var statisticService: StatisticServiceProtocol = StatisticService()
    private var currentQuestion: QuizQuestion?
    private var alert: AlertPresenter?
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //инициализация QF
        let questionFactory = QuestionFactory()
        questionFactory.delegate = self
        self.questionFactory = questionFactory
        
        //  statisticService = StatisticService()
        
        
        alert = AlertPresenter(viewController: self)
        alert?.viewController = self
        
        questionFactory.requestNextQuestion()
        setupUI()
    }
    
    // MARK: - Actions
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = false
        
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = true
        
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    // MARK: - Private functions
    private func setupUI() {
        imageView.layer.borderWidth = 8
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.contentMode = .scaleAspectFill
    }
    
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            correctAnswers += 1
        }
        
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {[weak self] in
            guard let self = self else { return }
            
            self.showNextQuestionOrResults()
        }
    }
    
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questionsAmount - 1 {
            
            statisticService.store(correct: correctAnswers, total: questionsAmount)
            let text = correctAnswers == questionsAmount ?
            "Поздравляем, вы ответили на 10 из 10! \nКоличество сыгранных квизов: \(statisticService.gamesCount) \nРекорд:\(statisticService.bestGame.correct)/10 - \(statisticService.bestGame.date.dateTimeString) \nСредняя точность:\(String(format: "%.2f", statisticService.totalAccuracy))%" :
            "Вы ответили на \(correctAnswers) из 10, попробуйте ещё раз! \nКоличество сыгранных квизов: \(statisticService.gamesCount) \nРекорд:\(statisticService.bestGame.correct)/10 - \(statisticService.bestGame.date.dateTimeString) \nСредняя точность:\(String(format: "%.2f", statisticService.totalAccuracy))%"
            
            let viewModel = AlertModel(
                title: "Этот раунд окончен!",
                message: text,
                buttonText: "Сыграть ещё раз",
                completion: { [weak self] in
                    guard let self = self else { return }
                    currentQuestionIndex = 0
                    correctAnswers = 0
                    questionFactory?.requestNextQuestion()
                }
            )
            
            showAlert(quiz: viewModel)
            setupUI()
        } else {
            currentQuestionIndex += 1
            
            questionFactory?.requestNextQuestion()
            setupUI()
        }
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(), question: model.text, questionNumber: "\(currentQuestionIndex+1)/\(questionsAmount)")
        return questionStep
    }
    
    private func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    func showAlert(quiz: AlertModel) {
        alert?.presentAlert(quiz: quiz)
        // questionFactory?.requestNextQuestion()
    }
    
    // MARK: - QuestionFactoryDelegate
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        
        currentQuestion = question
        let viewModel = convert(model: question)
        
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }
}
