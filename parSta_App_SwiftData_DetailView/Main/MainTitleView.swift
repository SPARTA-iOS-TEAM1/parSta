//
//  MainTitleView.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/8/24.
//

import SwiftUI
import UIKit
import TipKit

struct MainTitleView: View {
    @Parameter static var isFirstLaunch: Bool = true
    
    @State private var isShowingCommingSoon: Bool = false
    @Binding var tabIndex: TabIndex
    @State private var userName = checkNickName()
    @State private var userProfileImage = UserDefaults.standard.data(forKey: "profileImage")
    
    private let swiftDataTip: SwiftDataTips = SwiftDataTips()
    private let daliyQuizTip: DailyQuizTips = DailyQuizTips()
    
    init(tabIndex: Binding<TabIndex> = .constant(.home)) {
        _tabIndex = tabIndex
        
        do {
            try setupTips()
        } catch {
            print("Error initializing tips: \(error)")
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 0) {
                    // 앱 로고 및 사용자 정보 표시
                    Group {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 60)
                            .padding(.bottom, 15)
                            .offset(x: -proxy.size.width / 3.5)
                        
                        HStack(spacing: 15) {
                            Image(uiImage: UIImage(data: userProfileImage!)!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .offset(y: -25)
                                .onTapGesture {
                                    self.tabIndex = .account
                                }
                            
                            VStack(alignment: .leading) {
                                Text(userName)
                                    .font(.system(size: 25))
                                    .fontWeight(.bold)
                                
                                // 랭크 정보를 보여주는 뷰
                                RankDataView()
                            }
                        }
                        .offset(x: -proxy.size.width / 20)
                    }
                    // iOS 뉴스를 표시하는 뷰
                    NewsView()
                        .padding(.top, 30)
                        .padding(.bottom, 30)
                    
                    // 다른 뷰로 네비게이션링크를 통해 이동할 수 있는 트리거 뷰
                    // 1. SwiftData
                    // 2. Daily Quiz
                    VStack(spacing: 20) {
                        Text("Quiz")
                            .font(.headline)
                            .fontWeight(.medium)
                            .offset(x: -proxy.size.width / 2.5)
                        
                        
                        Group {
                            TipView(swiftDataTip, arrowEdge: .bottom)
                                .padding(.horizontal)
                            // SwfitData뷰로 이동
                            NavigationLink(destination: SwiftDataView()) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 350, height: 40)
                                        .foregroundStyle(Color.parsta)
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 347, height: 37)
                                        .foregroundStyle(Color.white)
                                    
                                    Text("Swift Data")
                                        .font(.system(size: 20))
                                        .fontWeight(.medium)
                                        .foregroundStyle(Color.parsta)
                                        .lineLimit(1)
                                }
                            }
                            
                            TipView(daliyQuizTip, arrowEdge: .bottom)
                                .padding(.horizontal)
                            // Daily Quiz로 이동
                            NavigationLink(destination: DailyQuizViewControllerWrapperWithCustomBackButton()) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 350, height: 40)
                                        .foregroundStyle(Color.parsta)
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 347, height: 37)
                                        .foregroundStyle(Color.white)
                                    
                                    Text("Daily Quiz")
                                        .font(.system(size: 20))
                                        .fontWeight(.medium)
                                        .foregroundStyle(Color.parsta)
                                        .lineLimit(1)
                                }
                            }
                            
                            // Comming Soon...
                            // 미구현 기능 - Alert로 경고 표시
                            Button(action: {
                                self.isShowingCommingSoon = true
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 350, height: 40)
                                        .foregroundStyle(Color.parsta)
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 347, height: 37)
                                        .foregroundStyle(Color.white)
                                    
                                    Text("Comming Soon...")
                                        .font(.system(size: 20))
                                        .fontWeight(.medium)
                                        .foregroundStyle(Color.parsta)
                                        .lineLimit(1)
                                }
                            }
                            .alert(isPresented: $isShowingCommingSoon) {
                                .init(title: Text("Comming Soon..."), message: Text("This feature is being prepared."), dismissButton: .default(Text("OK")))
                            }
                        }
                    }
                    
                    Rectangle()
                        .frame(height: 100)
                        .foregroundStyle(.clear)
                    
                    Spacer()
                }
            }
            .scrollIndicators(.hidden)
        }
        .onAppear() {
            if UserDefaults.standard.data(forKey: "profileImage") == nil {
                let profileImage = UIImage(named: "profile_image")
                let imageData = profileImage?.pngData()
                
                UserDefaults.standard.set(imageData, forKey: "profileImage")
            }
            
            self.userProfileImage = UserDefaults.standard.data(forKey: "profileImage")
            self.userName = checkNickName()
            
            Task {
                await SwiftDataTips.swiftDataTip.donate()
                await DailyQuizTips.dailyQuizTip.donate()
            }

            if SwiftDataTips.swiftDataTip.donations.count > 1 || DailyQuizTips.dailyQuizTip.donations.count > 1 {
                MainTitleView.isFirstLaunch = false
                
                UserDefaults.standard.set(MainTitleView.isFirstLaunch, forKey: "userFirstLaunch")
            } else {
                MainTitleView.isFirstLaunch = true
                
                UserDefaults.standard.set(MainTitleView.isFirstLaunch, forKey: "userFirstLaunch")
            }
            
            MainTitleView.isFirstLaunch = UserDefaults.standard.bool(forKey: "userFirstLaunch")
        }
    }
}
// 유저의 닉네임 값을 확인하는 함수
// UserDefaults에 저장된 이름이 nil일 경우 ""을 반환
func checkNickName() -> String {
    let check = UserDefaults.standard.string(forKey: "nickname")
    var nickName: String = ""
    guard check != nil else {
        return nickName
    }
    nickName = check!
    
    return nickName
}

// Tip을 표시할 때 기본 설정
private func setupTips() throws {
    // 모든 팁 노출
    // Tips.showAllTipsForTesting()
    
    // 특정 팁만 테스팅일 위해 노출
    // Tips.showTipsForTesting([tip1, tip2, tip3])
    
    // 앱에 정의된 모든 팁을 숨김
    //    Tips.hideAllTipsForTesting()
    
    // 팁과 관련한 모든 데이터를 삭제
//    try Tips.resetDatastore()
    
    // 모든 팁을 로드
    try Tips.configure()
}

#Preview {
    MainTitleView()
}
