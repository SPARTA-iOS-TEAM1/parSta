//
//  ImageEditorView.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/14/24.
//

import SwiftUI

struct ImageEditorView: View {
    
    @Binding private var inputImage: Data?
    @Binding private var editedImage: UIImage?
    @Binding private var showPhotosPicker: Bool
    
    @State private var cropRect: CGRect = CGRect(x: 50, y: 50, width: 200, height: 200)
    @State private var rotationAngle: Double = 0.0
    
    init(inputImage: Binding<Data?> = .constant(Data()), editedImage: Binding<UIImage?> = .constant(UIImage()), showPhotosPicker: Binding<Bool> = .constant(true)) {
        _editedImage = editedImage
        _inputImage = inputImage
        _showPhotosPicker = showPhotosPicker
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            GeometryReader { geometry in
                ZStack {
                    Image(uiImage: UIImage(data: self.inputImage!)!)
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(.degrees(rotationAngle))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    Rectangle()
                        .stroke(Color.blue, lineWidth: 2)
                        .frame(width: cropRect.width, height: cropRect.height)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
            }
            .frame(height: 300)
            
            VStack {
                Text("Rotate")
                Slider(value: $rotationAngle, in: 0...360, step: 1)
                    .padding()
            }
            
            Button(action: {
                let croppedImage = cropImage(UIImage(data: self.inputImage!)!, toRect: self.cropRect, rotationAngle: self.rotationAngle)
                editedImage = croppedImage
                
                let profileImage = self.editedImage
                let imageData = profileImage?.pngData()
                
                UserDefaults.standard.set(imageData, forKey: "profileImage")
                
                self.showPhotosPicker = false
            }) {
                Text("Apply Edits")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
    }
}

func cropImage(_ image: UIImage, toRect rect: CGRect, rotationAngle: Double) -> UIImage? {
    let renderer = UIGraphicsImageRenderer(size: image.size)
    
    return renderer.image { context in
        let cgImage = image.cgImage!
        let rotationTransform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle * .pi / 100))
        
        context.cgContext.translateBy(x: image.size.width / 2, y: image.size.height / 2)
        context.cgContext.rotate(by: CGFloat(rotationAngle * .pi / 100))
        context.cgContext.translateBy(x: -image.size.width / 2, y: -image.size.height / 2)
        
        if let croppedCgImage = cgImage.cropping(to: rect) {
            UIImage(cgImage: croppedCgImage).draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        }
    }
}

//#Preview {
//    ImageEditorView()
//}
