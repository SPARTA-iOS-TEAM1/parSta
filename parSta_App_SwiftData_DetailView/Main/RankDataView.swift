//
//  RankDataView.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/8/24.
//

import SwiftUI

struct RankDataView: View {
    
    @State private var progress: CGFloat = 0
    @State private var isColor: Color = .bronze
    @State private var rank = UserDefaults.standard.string(forKey: "rank")
    
    @State private var exp: Int = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // 랭크 이름 표시
                Text(self.rank ?? "")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 3)
                    .background(rankColorChange())
                    .cornerRadius(10)
                
                // 현재 랭크에 따른 필요 경험치와 현재 경험치 표시
                Text("\(self.exp) / \(maxExpChange())")
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            // 뷰가 생성될 때마다 유저의 닉네임, 경험치, 랭크 정보를 불러옴
            .onAppear() {
                withAnimation {
                    levelUp()
                    self.progress = progressChanger()
                    self.isColor = rankColorChange()
                    self.rank = rankNameChange()
                    
                    self.exp = UserDefaults.standard.integer(forKey: "exp")
                }
            }
            // 사용자의 경험치 표시
            ProgressBar(isColor: $isColor, progress: $progress, width: 250, height: 15, CRadius: 20)
        }
        
    }
}
// 경험치 바의 길이를 현재 경험치량의 비율에 맞춰 변경하는 함수
func progressChanger() -> CGFloat {
    let exp = UserDefaults.standard.integer(forKey: "exp")
    var progressValue: CGFloat = 0
    
    guard exp != 0 else {
        return progressValue
    }
    progressValue = CGFloat(exp)
    progressValue = progressValue / CGFloat(maxExpChange())
    
    return progressValue
}

// 사용자의 현재 랭크에 맞춰 랭크 색상을 변경하는 함수
func rankColorChange() -> Color {
    let level = UserDefaults.standard.integer(forKey: "level")
    
    switch level {
    case 0:
        return .bronze
    case 1:
        return .silver
    case 2:
        return .gold
    case 3:
        return .platinum
    case 4:
        return .diamond
    default:
        return .clear
    }
}

// 사용자의 현재 랭크에 따라 필요 경험치량을 변경하는 함수
func maxExpChange() -> Int {
    let level = UserDefaults.standard.integer(forKey: "level")
    
    switch level {
    case 0:
        return 100000
    case 1:
        return 200000
    case 2:
        return 300000
    case 3:
        return 400000
    case 4:
        return 500000
    default:
        return 0
    }
}

// 사용자의 현재 랭크에 따라 랭크 이름을 변경하는 함수
func rankNameChange() -> String {
    let level = UserDefaults.standard.integer(forKey: "level")
    
    switch level {
    case 0:
        return "Bronze"
    case 1:
        return "Silver"
    case 2:
        return "Gold"
    case 3:
        return "Platinum"
    case 4:
        return "Diamond"
    default:
        return ""
    }
}

#Preview {
    RankDataView()
}
