//
//  File.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/17/24.
//

import Foundation
import TipKit

struct SwiftDataTips: Tip {
    
    static let swiftDataTip = Event(id: "swiftData")
    
    var title: Text {
        Text("Swift Dictionary")
    }
    
    var message: Text? {
        Text("You can gain basic knowledge of swift")
    }
    
    var rules: [Rule] {
        #Rule(MainTitleView.$isFirstLaunch) {
            $0 == true
        }
    }
}

struct DailyQuizTips: Tip {
    
    static let dailyQuizTip = Event(id: "dailyQuiz")
    
    var title: Text {
        Text("Daily Quiz")
    }
    
    var message: Text? {
        Text("You can test your knowledge. Try to match the problem and build up your experience and rank up!")
    }
    
    var rules: [Rule] {
        #Rule(MainTitleView.$isFirstLaunch) {
            $0 == true
        }
    }
}
