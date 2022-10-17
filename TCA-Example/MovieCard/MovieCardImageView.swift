//
//  MovieCardImageView.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/15.
//

import SwiftUI

public struct MovieCardImageView: View {
  public let path: String
  public let cornerRadius: CGFloat
  public let contentMode: ContentMode
  
  public init(path: String, cornerRadius: CGFloat = 0, contentMode: ContentMode = .fill) {
    self.path = path
    self.cornerRadius = cornerRadius
    self.contentMode = contentMode
  }
  public var body: some View {
    let imagePath = Constants.posterImageURL.appendingPathComponent(path)
    
    GeometryReader { proxy in
      AsyncImage(url: imagePath) { image in
        image
          .resizable()
          .aspectRatio(contentMode: contentMode)
          .imageScale(.large)
          .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
          .cornerRadius(cornerRadius)
          
      } placeholder: {
        ProgressView()
          .progressViewStyle(.circular)
          .tint(.orange)
          .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
          .background(Color.black.cornerRadius(cornerRadius))
      }
    }
  }
}
