import UIKit

class QuizLogicManager: NSObject {
    var selectedAnswerIndex: Int? = nil
    var correctAnswerIndex: Int = 0
    var optionButtons: [UIButton] = []
    
    // 커스텀 라디오 버튼 생성 함수
    func createCustomRadioButton(title: String, tag: Int, target: Any, action: Selector) -> UIButton {
        var config = UIButton.Configuration.plain()
        
        // 선택되지 않은 상태에서는 텍스트와 circle 이미지가 모두 다크 그레이
        config.title = title
        config.baseForegroundColor = .darkGray
        config.image = UIImage(systemName: "circle")?.withRenderingMode(.alwaysTemplate) // 템플릿으로 설정해서 tintColor가 적용됨
        config.imagePlacement = .leading
        config.imagePadding = 10
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let button = UIButton(configuration: config)
        button.tintColor = .darkGray // circle 이미지는 다크 그레이
        button.tag = tag
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
    
    // 라디오 버튼 클릭 시 로직 처리
    @objc func optionSelected(_ sender: UIButton) {
        selectedAnswerIndex = sender.tag
        
        // 모든 버튼의 상태를 초기화
        optionButtons.forEach { button in
            var config = button.configuration
            config?.baseForegroundColor = .darkGray// 기본 상태의 텍스트는 다크 그레이
            config?.image = UIImage(systemName: "circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.darkGray) // 기본 원형 이미지
            button.configuration = config
        }
        
        // 선택된 버튼만 텍스트는 검은색, circle 이미지는 파란색으로 변경
        if var selectedConfig = sender.configuration {
            selectedConfig.baseForegroundColor = .black
            selectedConfig.image = UIImage(systemName: "largecircle.fill.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemBlue)
            sender.configuration = selectedConfig
        }
    }
}
