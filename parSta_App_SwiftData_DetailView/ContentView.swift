//
//  ContentView.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/2/24.
//

import SwiftUI

enum TabIndex {
    case home
    case setting
    case account
}

struct ContentView: View {
    
    @State var tabIndex: TabIndex = .home
    @State private var splashOn: Bool = true
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            // 앱 실행시 보여질 스플래시 뷰
            if self.splashOn {
                ParstaSplashView()
                    .zIndex(2)
                    .onAppear(perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation(.default) {
                                self.splashOn = false
                            }
                        }
                    })
            }
            
            // 메인 화면
            NavigationView {
                ZStack {
                    // 탭 뷰
                    // 현재 값에 따라 보여질 뷰 변경
                    if tabIndex == .home {
                        MainTitleView(tabIndex: $tabIndex)
                            .transition(.opacity)
                    } else if tabIndex == .setting {
                        SettingView()
                            .transition(.opacity)
                    } else if tabIndex == .account {
                        AccountView()
                            .transition(.opacity)
                    }
                }
                .animation(.smooth, value: self.tabIndex)
            }
            // 탭 뷰의 배경
            Rectangle()
                .ignoresSafeArea(.all)
                .frame(height: 60 + safeAreaBottomSizeCheck())
                .foregroundStyle(Color.parstaGray200)
                .shadow(color: .parsta.opacity(0.1), radius: 10)
            
            VStack(spacing: 0) {
                // 탭 뷰의 버튼
                HStack(spacing: 80) {
                    // 세팅 뷰 이동 트리거
                    Button(action: {
                            self.tabIndex = .setting
                    }) {
                        VStack {
                            Image(systemName: self.tabIndex == .setting ? "gearshape.fill" : "gearshape")
                                .font(.title3)
                                .fontWeight(.regular)
                            
                            Text("Setting")
                                .font(.subheadline)
                                .fontWeight(.regular)
                        }
                        .foregroundStyle(self.tabIndex == .setting ? Color.parsta : Color.parstaGray)
                    }
                    // 홈 뷰 이동 트리거
                    Button(action: {
                            self.tabIndex = .home
                    }) {
                        VStack {
                            Image(systemName: self.tabIndex == .home ? "house.fill" : "house")
                                .font(.title3)
                                .fontWeight(.regular)
                            
                            Text("Home")
                                .font(.subheadline)
                                .fontWeight(.regular)
                        }
                        .foregroundStyle(self.tabIndex == .home ? Color.parsta : Color.parstaGray)
                    }
                    // 사용자 뷰 이동 트리거
                    Button(action: {
                            self.tabIndex = .account
                    }) {
                        VStack {
                            Image(systemName: self.tabIndex == .account ? "person.fill" : "person")
                                .font(.title3)
                                .fontWeight(.regular)
                            
                            Text("Account")
                                .font(.subheadline)
                                .fontWeight(.regular)
                        }
                        .foregroundStyle(self.tabIndex == .account ? Color.parsta : Color.parstaGray)
                    }
                }
                // 기종에 따라 탭 뷰의 버튼들이 아래로 치우치는 현상 발생
                // 기종에 따라 홈 뷰의 버튼의 위치를 바꾸기 위한 뷰
                Rectangle()
                    .frame(height: safeAreaBottomSizeCheck())
                    .foregroundStyle(Color.parstaGray200)
            }
        }
        // 뷰가 생성될 때마다 사용자의 정보를 모두 가져오고, 값이 빈 값인 경우 임의의 값을 부여
        .onAppear() {
            if UserDefaults.standard.string(forKey: "nickname") == nil {
                UserDefaults.standard.set("Sparta0\(Int.random(in: 1...99))", forKey: "nickname")
            }
            if UserDefaults.standard.integer(forKey: "exp") <= 0 {
                UserDefaults.standard.set(0, forKey: "exp")
            }
            if UserDefaults.standard.string(forKey: "rank") == nil {
                UserDefaults.standard.set("Bronze", forKey: "rank")
            }
            if UserDefaults.standard.integer(forKey: "level") <= 0 {
                UserDefaults.standard.set(0, forKey: "level")
            }
            if UserDefaults.standard.data(forKey: "profileImage") == nil {
                let profileImage = UIImage(named: "profile_image")
                let imageData = profileImage?.pngData()
                
                UserDefaults.standard.set(imageData, forKey: "profileImage")
            }
        }
    }
}

// 기종에 따라 다른 패딩값을 주기 위한 함수
private func safeAreaBottomSizeCheck() -> CGFloat {
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    let window = windowScene?.windows.first
    
    let safeAreaBottomSize = window?.safeAreaInsets.bottom
    let paddingValue = CGFloat(safeAreaBottomSize == 0 ? 10 : 0)
    
    return paddingValue
}

#Preview {
    ContentView()
}
