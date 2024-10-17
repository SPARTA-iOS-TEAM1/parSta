//
//  ProgressBar.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/8/24.
//

import SwiftUI

struct ProgressBar: View {
    
    @Binding var isColor: Color
    @Binding var progress: CGFloat
    var width: CGFloat
    var height: CGFloat
    var CRadius: CGFloat
    
    var body: some View {
        
        // 사용자의 경험치 바를 생성하는 뷰
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(width: self.width, height: self.height)
                .cornerRadius(self.CRadius)
                .foregroundStyle(.parstaGray.opacity(0.5))
            
            Rectangle()
                .frame(width: self.width * self.progress, height: self.height)
                .cornerRadius(self.CRadius)
                .foregroundStyle(LinearGradient(colors: [isColor, isColor.opacity(0.7)], startPoint: .leading, endPoint: .trailing))
        }
        
    }
}

//#Preview {
//    ProgressBar()
//}
