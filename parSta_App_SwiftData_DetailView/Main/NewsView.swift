//
//  NewsView.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/8/24.
//

import SwiftUI

struct NewsView: View {
    
    private let newsImage: [String] = ["news1",
                                       "news2",
                                       "news3",
                                       "news4",
                                       "news5"]
    @State private var imageCount: Int = 0
    @State private var selectedImage: String = "news1"
    private var timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack {
            Text("iOS News")
                .font(.headline)
                .fontWeight(.medium)
                .offset(x: -140)
            
            TabView(selection: $selectedImage) {
                
                ForEach(newsImage, id: \.self) { item in
                    Image(item)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 160)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }
            }
            .tabViewStyle(.page)
            .frame(height: 180)
            .onReceive(self.timer) { _ in
                withAnimation {
                    self.imageCount = (imageCount + 1) % newsImage.count
                    self.selectedImage = self.newsImage[self.imageCount]
                }
            }
        }
    }
}

#Preview {
    NewsView()
}
