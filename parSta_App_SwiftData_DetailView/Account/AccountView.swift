//
//  AccountView.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/8/24.
//

import SwiftUI

struct AccountView: View {
    
    @State private var userName: String = checkNickName()
    @State private var editNickName: String = ""
    @State private var edit: Bool = false
    @State private var blankUserName: Bool = false
    @State private var selectedImageData: Data?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                Rectangle()
                    .frame(height: 40)
                    .opacity(0)
                
                UserProfileView(selectedImageData: $selectedImageData)
                    .padding(.bottom, 20)
                
                HStack {
                    if self.edit {
                        TextField("Edit your Nickname", text: $editNickName)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 200)
                        
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(Color.parsta)
                            .onTapGesture {
                                guard self.editNickName.count > 0 else {
                                    self.blankUserName = true
                                    return
                                }
                                
                                UserDefaults.standard.set(self.editNickName, forKey: "nickname")
                                self.userName = self.editNickName
                                
                                withAnimation {
                                    self.edit.toggle()
                                }
                            }
                    } else {
                        Text(self.userName)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Image(systemName: "pencil.circle.fill")
                            .font(.title2)
                            .foregroundStyle(Color.parstaGray)
                            .onTapGesture {
                                self.editNickName = ""
                                
                                withAnimation {
                                    self.edit.toggle()
                                }
                            }
                    }
                }
                .alert(isPresented: $blankUserName) {
                    .init(title: Text("Error!!"), message: Text("Nickname cannot be an empty value."), dismissButton: .default(Text("OK")))
                }
                .padding(.bottom, 20)
                
                RankDataView()
                    .padding(.bottom, 30)
                
                Text("Rank Information")
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundStyle(Color.secondary)
                    .padding(.bottom, 10)
                    .offset(x: -100)
                
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 450)
                        .foregroundStyle(Color.white)
                        .shadow(color: Color.parsta, radius: 2)
                    
                    RankInfomation()
                        .padding(.top, 20)
                }
                
                Rectangle()
                    .frame(height: 100)
                    .opacity(0)
                
                Spacer()
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    AccountView()
}
