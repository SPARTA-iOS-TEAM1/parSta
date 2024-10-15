//
//  ParstaSplashView.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/10/24.
//

import SwiftUI

struct ParstaSplashView: View {
    var body: some View {
            
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 100)
                .padding(.horizontal, UIScreen.main.bounds.width)
                .padding(.vertical, 360)
                .background(Color.white)
        
    }
}

#Preview {
    ParstaSplashView()
}
