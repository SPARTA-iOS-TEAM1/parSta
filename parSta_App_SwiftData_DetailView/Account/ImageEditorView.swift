//
//  ImageEditorView.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/14/24.
//

import SwiftUI
import PhotosUI

struct ImageEditorView: View {
    
    @State private var cropArea: CGRect = .init(x: 0, y: 0, width: 100, height: 100)
    @State private var ImageViewSize: CGSize = .zero
    @State private var croppedImage: UIImage?
    
    @Binding public var image: Data?
    @Binding public var showImageEditor: Bool
    
    init(image: Binding<Data?> = .constant(UserDefaults.standard.data(forKey: "profileImage")), croppedImage: UIImage = UIImage(), showImageEditor: Binding<Bool> = .constant(true)) {
        _image = image
        _showImageEditor = showImageEditor
        self.croppedImage = croppedImage
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            
            if let imageData = self.image, let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .overlay(alignment: .topLeading) {
                        GeometryReader { geometry in
                            CropBox(rect: $cropArea)
                                .onAppear {
                                    self.ImageViewSize = geometry.size
                                }
                                .onChange(of: geometry.size) {
                                    self.ImageViewSize = $0
                                }
                        }
                    }
                
                Button(action: {
                    croppedImage = crop(image: image, cropArea: cropArea, imageViewSize: ImageViewSize)
                    if let croppedImage {
                        let profileImage = croppedImage
                        let imageData = profileImage.pngData()
                        
                        self.image = imageData
                        UserDefaults.standard.set(imageData, forKey: "profileImage")
                    }
                    self.showImageEditor = false
                }) {
                    Text("Crop")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.parsta)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .background(Color.parstaGray200)
                        .cornerRadius(20)
                        .shadow(radius: 2)
                }
                .padding(.top, 30)
                
                Spacer()
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
    }
}

private func crop(image: UIImage, cropArea: CGRect, imageViewSize: CGSize) -> UIImage? {
    let scaleX = image.size.width / imageViewSize.width * image.scale
    let scaleY = image.size.height / imageViewSize.height * image.scale
    let scaledCropArea = CGRect(
        x: cropArea.origin.x * scaleX,
        y: cropArea.origin.y * scaleY,
        width: cropArea.size.width * scaleX,
        height: cropArea.size.height * scaleY
    )
    
    guard let cutImageRef: CGImage = image.cgImage?.cropping(to: scaledCropArea) else {
        return nil
    }
    
    return UIImage(cgImage: cutImageRef)
}

#Preview {
    ImageEditorView()
}
