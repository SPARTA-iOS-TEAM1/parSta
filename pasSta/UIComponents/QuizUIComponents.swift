import UIKit

class QuizUIComponents {
   // 문제에 대한 Label
    static func createQuestionLabel() -> UILabel {
        let label = UILabel()
        label.text = "What are the keywords to create variables?"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }
    
    static func createPickAnswerLabel() -> UILabel {
        let label = UILabel()
        label.text = "Pick a Answer"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }
    
    // 코드 블록을 표시할 UILabel
    static func createCodeBlockLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.monospacedSystemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.textAlignment = .left
        label.isHidden = true
        return label
    }
    
    // 선택지를 담을 StackView
    static func createOptionsStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }
    
    // 제출 버튼
    static func createSubmitButton(target: Any, action: Selector) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = "Submit"
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
        
        let button = UIButton(configuration: config)
        button.isEnabled = false
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
}
