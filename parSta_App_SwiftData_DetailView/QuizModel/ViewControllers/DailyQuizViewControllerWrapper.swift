import SwiftUI
import UIKit

// SwiftUI에서 UIKit의 UIViewController를 사용하기 위해 UIViewControllerRepresentable 사용
struct DailyQuizViewControllerWrapper: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    
    func updateUIViewController(_ uiViewController: DailyQuizViewController, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> DailyQuizViewController {
        let quizViewController = DailyQuizViewController()
        
        // SwiftUI로 돌아가기 위한 dismissAction 설정
        quizViewController.dismissAction = {
            presentationMode.wrappedValue.dismiss()
        }
        
        return quizViewController
    }
}

struct DailyQuizViewControllerWrapperWithCustomBackButton: View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        DailyQuizViewControllerWrapper()
            .navigationBarBackButtonHidden(true) // 기본 백버튼 숨기기
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // SwiftUI에서 뒤로 가는 동작
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("BackButton") // "BackButton"이라는 이미지로 커스텀 백버튼 추가
                    }
                }
                ToolbarItem(placement: .principal) { // 네비게이션 타이틀 추가
                    Text("Daily Quiz")
                        .font(.headline)
                        .foregroundColor(.black) // 원하는 색상으로 변경 가능
                }
            }
    }
}
