//
//  ParstaDefaultsProfileImage.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/14/24.
//

import SwiftUI

struct ParstaDefaultsProfileImage: View {
    
    @Binding private var showDefaultsImagePicker: Bool
    @Binding private var selectedImageData: Data?
    
    private let columns: [GridItem] = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    private let defaultsProfileImage: [String] = ["승철",
                                                  "정한",
                                                  "지수",
                                                  "준휘",
                                                  "순영",
                                                  "원우",
                                                  "지훈",
                                                  "명호",
                                                  "민규",
                                                  "도겸",
                                                  "승관",
                                                  "한솔",
                                                  "찬"]
    
    init(showDefaultsImagePicker: Binding<Bool> = .constant(true), selectedImageData: Binding<Data?> = .constant(Data())) {
        _showDefaultsImagePicker = showDefaultsImagePicker
        _selectedImageData = selectedImageData
    }
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: self.columns) {
                ForEach(defaultsProfileImage, id: \.self) { item in
                    Button(action: {
                        let profileImage = UIImage(named: item)
                        let imageData = profileImage?.pngData()
                        
                        self.selectedImageData = imageData
                        UserDefaults.standard.set(imageData, forKey: "profileImage")
                        
                        showDefaultsImagePicker = false
                    }) {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 120)
                            .foregroundStyle(Color.white)
                            .shadow(color: Color.parsta, radius: 1)
                            .overlay {
                                Image(item)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            }
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 20)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ParstaDefaultsProfileImage()
}
