//
//  SwiftDataView.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/8/24.
//

import SwiftUI

struct SwiftDataView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    private var swiftData: [SwiftData] = swiftDataSet
    @State private var id: Int = 0
    @State private var presentSideMenu: Bool = false
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .zIndex(1)
                .edgesIgnoringSafeArea(.all)
                .foregroundStyle(presentSideMenu ? Color.black.opacity(0.2) : .clear)
                .animation(.default, value: presentSideMenu)
                .onTapGesture {
                    self.presentSideMenu = false
                }
            
            SideMenuView(presentSideMenu: $presentSideMenu, id: $id)
                .zIndex(2)
                .offset(x: presentSideMenu ? 150 : 600, y: 0)
                .animation(.default, value: presentSideMenu)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 25))
                            .foregroundStyle(Color.parstaGray)
                    }
                    .padding(.leading, 35)
                    
                    Spacer()
                    
                    Text("\(self.id + 1). \(swiftData[self.id].title)")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        presentSideMenu = true
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 25))
                            .foregroundStyle(Color.parstaGray)
                            .padding(.trailing, 35)
                    })
                }
                Spacer()
            }
            
            VStack(spacing: 0) {
                
                Rectangle()
                    .frame(height: 50)
                    .opacity(0)
                
                Text(swiftData[self.id].title)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .padding(.bottom, 30)
                
                ScrollView {
                    Text(swiftData[self.id].content)
                        .font(.system(size: 15))
                        .fontWeight(.light)
                        .lineSpacing(2)
                        .padding(10)
                        .padding(.horizontal, 20)
                }
                .frame(width: UIScreen.main.bounds.width, height: 350)
                .padding(.bottom, 10)
                .scrollIndicators(.hidden)
                
                HStack(spacing: 0) {
                    Text("< Prev")
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.parsta)
                        .onTapGesture {
                            withAnimation {
                                if self.id <= 0 {
                                    self.id = swiftData.count - 1
                                } else {
                                    self.id -= 1
                                }
                            }
                        }
                    
                    Spacer()
                    
                    Text("Next >")
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.parsta)
                        .onTapGesture {
                            withAnimation {
                                if self.id >= swiftData.count - 1 {
                                    self.id = 0
                                } else {
                                    self.id += 1
                                }
                            }
                        }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    SwiftDataView()
}
