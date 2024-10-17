//
//  SettingView.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/8/24.
//

import SwiftUI

// 현재 언어 상태를 열거형으로 정의
enum LanguageSetting {
    case english
    case korean
}

struct SettingView: View {
    
    @State private var language: LanguageSetting = .english
    @State private var helpCenterCall: Bool = false
    var body: some View {
        
        List {
            // 언어 설정을 변경
            HStack {
                Image(systemName: "globe")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.parstaGray)
                
                Text("Language")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.black)
                
                Spacer()
                
                Picker("", selection: $language) {
                    Text("English (US)").tag(LanguageSetting.english)
                    
                    Text("Korean (KR)").tag(LanguageSetting.korean)
                }
            }
            
            // 사용자의 보안설정을 변경(미구현)
            HStack {
                Image(systemName: "lock.shield")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.parstaGray)
                
                Text("Privacy Policy")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.black)
            }
            
            // 앱의 고객센터에 연결(미구현)
            // 클릭시 제작자의 정보 표시
            HStack {
                Image(systemName: "info.circle")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.parstaGray)
                
                Text("Help center")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.black)
            }
            .onTapGesture {
                self.helpCenterCall = true
            }
            
        }
        .alert(isPresented: $helpCenterCall) {
            Alert(title: Text("Help Center"),
                  message: Text("Team Name: 저희뭐하조?(1조)\nTeam Leader: 장상경\nTeam Member: 김상민, 박채현"),
                  dismissButton: .default(Text("OK")))
        }
        .listStyle(.plain)
    }
}

#Preview {
    SettingView()
}
