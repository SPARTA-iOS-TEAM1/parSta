//
//  RankInfomation.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/10/24.
//

import SwiftUI

struct RankInfomation: View {
    
    private let rank: [Rank] = rankSet
    
    var body: some View {
        VStack(spacing: 20) {
            
            // 앱에서 지원하는 랭크와 필요 경험치량을 표시하는 뷰
            // rankSet에 랭크를 추가하는 것으로 간단히 값을 추가 가능(재사용성)
            ForEach(rank, id: \.self) { rank in
                HStack(spacing: 0) {
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 120, height: 50)
                            .foregroundStyle(rank.color)
                        
                        Text(rank.rankName)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                    }
                    .padding(.trailing, 15)

                    // 랭크업에 필요한 경험치를 표시
                    VStack(alignment: .leading) {
                        Text("Experience value\nrequired to level up:")
                            .font(.headline)
                            .fontWeight(.medium)
                        
                        Text("\(rank.maxExp) exp")
                            .font(.headline)
                            .fontWeight(.black)
                    }
                }
                .padding(.horizontal, 10)
            }
        }
    }
}

#Preview {
    RankInfomation()
}
