//
//  MenuListView.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/2/24.
//

import SwiftUI

struct MenuListView: View {
    
    private var swiftData: [SwiftData] = swiftDataSet
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Text("Swift Data")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            Rectangle()
                .frame(height: 5)
                .foregroundStyle(Color.gray.opacity(0.1))
                .padding(.bottom, 20)
            
            ScrollView {
                ForEach((swiftData), id: \.self) { data in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 300, height: 50)
                            .foregroundStyle(Color.blue)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 295, height: 45)
                            .foregroundStyle(Color.white)
                        
                        Text(data.title)
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundStyle(Color.blue)
                            .lineLimit(1)
                    }
                    .padding(.bottom, 15)
                }
                .padding(.top, 10)
            }
        }
    }
}

#Preview {
    MenuListView()
}
