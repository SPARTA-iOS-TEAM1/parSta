//
//  DailyQuizView.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/10/24.
//

import SwiftUI

struct DailyQuizView: View {
    
    @State private var userExp: Int = 0
    
    var body: some View {
        
        Button(action: {
            self.userExp += 10000
            UserDefaults.standard.set(self.userExp, forKey: "exp")
            levelUp()
            print("exp: \(self.userExp)")
        }) {
            Text("Exp Up")
                .font(.title)
                .fontWeight(.bold)
                .padding(20)
                .background(Color.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding(.bottom, 50)
        .onAppear() {
            self.userExp = UserDefaults.standard.integer(forKey: "exp")
        }
        
        Button(action: {
            UserDefaults.standard.set("Sparta0\(Int.random(in: 1...99))", forKey: "nickname")
            
            UserDefaults.standard.set(0, forKey: "exp")
            
            UserDefaults.standard.set("Bronze", forKey: "rank")
            
            UserDefaults.standard.set(0, forKey: "level")
            
            let profileImage = UIImage(named: "profile_image")
            let imageData = profileImage?.pngData()
            
            UserDefaults.standard.set(imageData, forKey: "profileImage")
        }) {
            Text("User Data Reset")
                .font(.title)
                .fontWeight(.bold)
                .padding(20)
                .background(Color.red)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

func levelUp() {
    var level = UserDefaults.standard.integer(forKey: "level")
    var exp = UserDefaults.standard.integer(forKey: "exp")
    
    switch level {
    case 0:
        if exp >= 100000 {
            level += 1
            exp = 0
            UserDefaults.standard.set(exp, forKey: "exp")
            UserDefaults.standard.set(level, forKey: "level")
        } else {
            return
        }
    case 1:
        if exp >= 200000 {
            level += 1
            exp = 0
            UserDefaults.standard.set(exp, forKey: "exp")
            UserDefaults.standard.set(level, forKey: "level")
        } else {
            return
        }
    case 2:
        if exp >= 300000 {
            level += 1
            exp = 0
            UserDefaults.standard.set(exp, forKey: "exp")
            UserDefaults.standard.set(level, forKey: "level")
        } else {
            return
        }
    case 3:
        if exp >= 400000 {
            level += 1
            exp = 0
            UserDefaults.standard.set(exp, forKey: "exp")
            UserDefaults.standard.set(level, forKey: "level")
        } else {
            return
        }
    case 4:
        if exp >= 500000 {
            exp = 500000
            UserDefaults.standard.set(exp, forKey: "exp")
        } else {
            return
        }
    default:
        level = 0
    }
    
}


#Preview {
    DailyQuizView()
}
