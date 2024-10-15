import Foundation

class QuizDataManager {
    
    // 싱글톤 패턴으로 QuizDataManager 공유 인스턴스 생성
    static let shared = QuizDataManager()
    
    // JSON 파일에서 퀴즈 데이터를 불러오는 함수
    func loadQuizzesFromJSON() -> [Quiz]? {
        guard let url = Bundle.main.url(forResource: "quizzes", withExtension: "json") else {
            print("quizzes.json 파일을 찾을 수 없습니다.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let quizzes = try JSONDecoder().decode([Quiz].self, from: data)
            return quizzes
        } catch {
            print("JSON 파일을 파싱하는 중 오류 발생: \(error)")
            return nil
        }
    }
}
