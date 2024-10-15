import UIKit

class DailyQuizViewController: UIViewController {
    
    // 외부 파일에서 가져온 UI 컴포넌트들 (타이포 수정)
    let questionLabel = QuizUIComponents.createQuestionLabel()
    let pickAnswerLabel = QuizUIComponents.createPickAnswerLabel()
    let codeBlockLabel = QuizUIComponents.createCodeBlockLabel()
    let optionsStackView = QuizUIComponents.createOptionsStackView()
    lazy var submitButton = QuizUIComponents.createSubmitButton(target: self, action: #selector(submitButtonTapped))
    
    // 퀴즈 로직 매니저
    var quizLogic = QuizLogicManager()
    
    // 퀴즈 데이터 매니저
    var quizDataManger = QuizDataManager.shared
    
    // 퀴즈 해결 기록 매니저
    var solvedQuizManager = SolvedQuizManager.shared
    
    // 코드 블록 높이 제약을 관리할 변수
    var codeBlockLabelHeightConstraint: NSLayoutConstraint?
    
    // 현재 표시할 퀴즈 데이터
    var currentQuiz: Quiz?
    var currentQuizIndex: Int = 0 // 현재 퀴즈 인덱스 추적
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 기본 설정
        view.backgroundColor = .white
        navigationItem.title = "Daily Quiz"
        
        setupUI()
        
        if let quizzes = quizDataManger.loadQuizzesFromJSON(), let firstQuiz = quizzes.first {
            loadNextQuiz()
        } else {
            showAlert(message: "퀴즈 데이터를 불러오지 못했습니다.")
        }
        
        // 퀴즈 데이터를 로드하고 첫 번째 퀴즈를 설정
    }
    
    // UI 배치 함수
    private func setupUI() {
        
        // 초기 비활성화 설정
        submitButton.isEnabled = false
        
        // 1. 상단 지문
        let questionContainerView = UIView()
        view.addSubview(questionContainerView)
        questionContainerView.addSubview(questionLabel)
        questionContainerView.addSubview(codeBlockLabel)
        setupQuestionContainer(questionContainerView)
        
        // 2. 중간 선택지 부분
        let answerContainerView = UIView()
        view.addSubview(answerContainerView)
        answerContainerView.addSubview(pickAnswerLabel)
        answerContainerView.addSubview(optionsStackView)
        setupAnswerContainer(answerContainerView)
        
        
        // 3. 하단 제출 버튼 부분
        view.addSubview(submitButton)
        setupSubmitButton()
    }
    
    // UI 레이아웃 설정
    private func setupQuestionContainer(_ container: UIView) {
        container.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        codeBlockLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // codeBlockLabel의 높이 제약 조건을 저장
        codeBlockLabelHeightConstraint = codeBlockLabel.heightAnchor.constraint(equalToConstant: 0)
        
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            // questionLabel 레이아웃 설정
            questionLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 40),
            questionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),

            // codeBlockLabel 레이아웃 설정
            codeBlockLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            codeBlockLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            codeBlockLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            
            // codeBlockLabel의 초기 높이 제약
            codeBlockLabelHeightConstraint!

        ])
    }
    
    private func setupAnswerContainer(_ container: UIView) {
        container.translatesAutoresizingMaskIntoConstraints = false
        pickAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: codeBlockLabel.bottomAnchor, constant: 24),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pickAnswerLabel.topAnchor.constraint(equalTo: container.topAnchor),
            pickAnswerLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            pickAnswerLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            optionsStackView.topAnchor.constraint(equalTo: pickAnswerLabel.bottomAnchor, constant: 20),
            optionsStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            optionsStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            optionsStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
    
    private func setupSubmitButton() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: optionsStackView.bottomAnchor, constant: 40),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // 퀴즈 데이터를 UI에 적용하는 함수
    func configureQuiz(quiz: Quiz, index: Int) {
        currentQuiz = quiz
        currentQuizIndex = index
        
        // 문제 텍스트 설정
        questionLabel.text = quiz.question
        
        // 코드 블록이 있으면 보이게 설정, 없으면 숨김 처리
        if let code = quiz.code {
            codeBlockLabel.text = code
            codeBlockLabel.isHidden = false
            codeBlockLabelHeightConstraint?.constant = codeBlockLabel.intrinsicContentSize.height  // 코드 블록의 실제 높이 설정
        } else {
            codeBlockLabel.isHidden = true
            codeBlockLabelHeightConstraint?.constant = 0  // 높이 0으로 설정
        }
        
        // 기준 옵션 버튼을 모두 제거
        optionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        quizLogic.optionButtons.removeAll()
        
        // 선택지 버튼들을 스택뷰에 추가
        for (index, answer) in quiz.answers.enumerated() {
            let button = quizLogic.createCustomRadioButton(title: answer, tag: index, target: self, action: #selector(optionSelected(_:)))
            optionsStackView.addArrangedSubview(button)
            quizLogic.optionButtons.append(button)
        }
        
        // 정답 인덱스 설정
        quizLogic.correctAnswerIndex = quiz.correctAnswerIndex
    }
    
    @objc private func optionSelected(_ sender: UIButton) {
        quizLogic.optionSelected(sender)
        
        // 답안 선택 시 submit 버튼 활성화
        submitButton.isEnabled = true
    }
    
    @objc private func submitButtonTapped() {
        print("버튼 누름")
        
        guard let selectedAnswerIndex = quizLogic.selectedAnswerIndex else {
            let alert = UIAlertController(title: "Error", message: "Please select an answer.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let isCorrect = selectedAnswerIndex == quizLogic.correctAnswerIndex
        if isCorrect {
            solvedQuizManager.markQuizAsSolved(index: currentQuizIndex)
            
            let alert = UIAlertController(title: "Congratulations 🎉", message: "You got it right!", preferredStyle: .alert)
            let goHomeAction = UIAlertAction(title: "Go Home", style: .default) { _ in
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            let nextQuizAction = UIAlertAction(title: "Next Quiz", style: .default) { _ in
                self.loadNextQuiz()
            }
            
            alert.addAction(goHomeAction)
            alert.addAction(nextQuizAction)
            present(alert, animated: true, completion: nil)
        } else {
            print("incorrect")
            let alert = UIAlertController(title: "Oops!", message: "Wrong answer.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    // 정답 여부에 따른 Alert 표시
    private func showAlert(message: String, isCorrect: Bool = false) {
        let alert = UIAlertController(title: isCorrect ? "축하합니다!" : "Oops!", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if isCorrect {
                self.loadNextQuiz()
            }
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func loadNextQuiz() {
        if let quizzes = quizDataManger.loadQuizzesFromJSON() {
            // 현재 인덱스에서 다음 퀴즈 찾기
            while currentQuizIndex < quizzes.count {
                if !solvedQuizManager.isQuizSolved(index: currentQuizIndex) {
                    // 푼 문제가 아니면 로드
                    let nextQuiz = quizzes[currentQuizIndex]
                    configureQuiz(quiz: nextQuiz, index: currentQuizIndex)
                    return
                }
                
                currentQuizIndex += 1
            }
            
            // 모든 퀴즈를 다 풀었을 경우 메시지
            let alert = UIAlertController(title: "All quizzes completed!", message: "You've completed all quizzes.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
