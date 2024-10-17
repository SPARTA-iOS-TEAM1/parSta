//
//  MainTitleView.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/8/24.
//

import SwiftUI
import UIKit


struct MainTitleView: View {
    
    @State private var isShowingCommingSoon: Bool = false
    @Binding var tabIndex: TabIndex
    @State private var userName = checkNickName()
    @State private var userProfileImage = UserDefaults.standard.data(forKey: "profileImage")
    
    init(tabIndex: Binding<TabIndex> = .constant(.home)) {
        _tabIndex = tabIndex
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
                        
                        // SwfitData뷰로 이동
                        Group {
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
            self.userProfileImage = UserDefaults.standard.data(forKey: "profileImage")
            self.userName = checkNickName()
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

#Preview {
    MainTitleView()
}
