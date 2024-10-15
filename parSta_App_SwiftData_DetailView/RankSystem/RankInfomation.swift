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
