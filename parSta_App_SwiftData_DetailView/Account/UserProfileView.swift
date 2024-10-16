//
//  UserProfileView.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/11/24.
//

import SwiftUI
import PhotosUI

struct UserProfileView: View {
    
    @State private var selectedImage: PhotosPickerItem?
    
    @Binding public var selectedImageData: Data?
    
    @State private var actionSheetShowing: Bool = false
    @State private var showDefaultsImagePicker: Bool = false
    @State private var showPhotosPicker: Bool = false
    @State private var showImageEditor: Bool = false
    
    init(selectedImageData: Binding<Data?> = .constant(Data())) {
        _selectedImageData = selectedImageData
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            if let selectedImageData, let image = UIImage(data: selectedImageData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
            
            Button(action: {
                self.actionSheetShowing = true
            }) {
                Text("Change")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.parsta)
                    .shadow(color: Color.diamond, radius: 3)
            }
            .padding(.top, 5)
            .onAppear() {
                self.selectedImageData = UserDefaults.standard.data(forKey: "profileImage")
            }
        }
        .actionSheet(isPresented: $actionSheetShowing) {
            ActionSheet(title: Text("Select Profile Image"), message: nil, buttons: [
                .default(Text("Choose from Gallery")) {
                    self.showPhotosPicker = true
                },
                .default(Text("Choose from Defaults")) {
                    self.showDefaultsImagePicker = true
                },
                .cancel()
            ])
        }
        .photosPicker(isPresented: $showPhotosPicker, selection: $selectedImage)
        .onChange(of: selectedImage) { _, image in
            Task {
                if let data = try? await image?.loadTransferable(type: Data.self) {
                    selectedImageData = data
                    UserDefaults.standard.set(data, forKey: "profileImage")
                    
                    self.showImageEditor = true
                }
            }
        }
        .sheet(isPresented: $showImageEditor) {
            if self.selectedImage != nil {
                ImageEditorView(image: $selectedImageData, showImageEditor: $showImageEditor)
            }
        }
        .sheet(isPresented: $showDefaultsImagePicker) {
            VStack {
                Text("Select the profile you want")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.secondary)
                    .padding(.top, 20)
                
                ParstaDefaultsProfileImage(showDefaultsImagePicker: $showDefaultsImagePicker, selectedImageData: $selectedImageData)
            }
        }
        .onAppear() {
            self.selectedImageData = UserDefaults.standard.data(forKey: "profileImage")
        }
    }
}

func saveImageToUserDefaults(_ image: UIImage) {
    let profileImage = image
    let imageData = profileImage.pngData()
    
    UserDefaults.standard.set(imageData, forKey: "profileImage")
}

#Preview {
    UserProfileView()
}
