import Foundation

class SolvedQuizManager {
    
    static let shared = SolvedQuizManager()
    
    private let solvedQuizKey = "solvedQuizzes"
    
    // 푼 문제의 인덱스를 저장
    func markQuizAsSolved(index: Int) {
        var solvedQuizzes = getSolvedQuizzes()
        solvedQuizzes.append(index)
        UserDefaults.standard.set(solvedQuizzes, forKey: solvedQuizKey)
    }
    
    // 저장된 푼 문제의 인덱스 리스트를 가져옴
    func getSolvedQuizzes() -> [Int] {
        return UserDefaults.standard.array(forKey: solvedQuizKey) as? [Int] ?? []
    }
    
    // 해당 퀴즈 인덱스가 이미 풀렸는지 확인
    func isQuizSolved(index: Int) -> Bool {
        return getSolvedQuizzes().contains(index)
    }
}
