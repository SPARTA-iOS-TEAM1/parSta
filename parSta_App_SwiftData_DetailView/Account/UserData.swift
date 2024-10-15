//
//  UserData.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/10/24.
//

import SwiftUI

struct UserData: View {
    
    private let userName = UserDefaults.standard.string(forKey: "nickname")
    private let userProfileImage = UserDefaults.standard.data(forKey: "profileImage")
    
    var body: some View {
        
        VStack {
            Image(uiImage: UIImage(data: userProfileImage!)!)
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            Text(userName ?? "")
                .font(.largeTitle)
                .fontWeight(.bold)
                        
            RankDataView()
        }
    }
}
    
#Preview {
    UserData()
}
