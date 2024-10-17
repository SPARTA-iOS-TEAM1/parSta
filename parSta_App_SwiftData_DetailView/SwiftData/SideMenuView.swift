//
//  SideMenuView.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/3/24.
//

import SwiftUI

struct SideMenuView: View {
    
    private var swiftData: [SwiftData] = swiftDataSet
    @Binding private var presentSideMenu: Bool
    @Binding private var id: Int
    
    init(presentSideMenu: Binding<Bool> = .constant(false), id: Binding<Int> = .constant(0)) {
        _presentSideMenu = presentSideMenu
        _id = id
    }
    
    var body: some View {
        // 사이드메뉴 뷰
        ZStack {
            // 사이드메뉴의 배경 지정
            Rectangle()
                .edgesIgnoringSafeArea(.all)
                .foregroundStyle(Color.white)
                .shadow(color: .gray, radius: 5)
            
            // 사이드메뉴의 내부 구성
            VStack(alignment: .leading, spacing: 0) {
                
                HStack(spacing: 0) {
                    // 사이드메뉴를 닫는 트리거
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.parstaGray)
                        .padding(.trailing, 30)
                        .onTapGesture {
                            self.presentSideMenu = false
                        }
                    
                    Text("Swift Data")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                }
                .padding(.bottom, 20)
                .padding(.leading, safeAreaBottomSizeCheck())
                
                // 사이드메뉴 목록과 제목의 구분선
                Rectangle()
                    .frame(height: 5)
                    .foregroundStyle(Color.parstaGray.opacity(0.1))
                    .padding(.bottom, 20)
                
                // 사이드메뉴 목록
                ScrollView {
                    ForEach((swiftData), id: \.self) { data in
                        ZStack() {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 210, height: 50)
                                .foregroundStyle(Color.parsta)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 205, height: 45)
                                .foregroundStyle(Color.white)
                                .onTapGesture {
                                    self.presentSideMenu = false
                                    self.id = data.id
                                }
                                .overlay {
                                    Text("\(data.id + 1). \(data.title)")
                                        .font(.system(size: 15))
                                        .fontWeight(.medium)
                                        .foregroundStyle(Color.parsta)
                                        .lineLimit(1)
                                        .padding(.horizontal, 10)
                                }
                        }
                        .padding(.bottom, 15)
                    }
                    .padding(.top, 10)
                }
                .scrollIndicators(.hidden)
                .padding(.leading, safeAreaBottomSizeCheck())
            }
        }
    }
}

// 폰 기존에 따른 패딩값 변경 함수
// 홈 버튼이 있는 기종은 패딩 값이 감소(iPhon SE 등)
private func safeAreaBottomSizeCheck() -> CGFloat {
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    let window = windowScene?.windows.first
    
    let safeAreaBottomSize = window?.safeAreaInsets.bottom
    let paddingValue = CGFloat(safeAreaBottomSize == 0 ? 20 : 30)
    
    return paddingValue
}

#Preview {
    SideMenuView()
}
