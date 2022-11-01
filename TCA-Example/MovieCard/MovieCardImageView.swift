//
//  MovieCardImageView.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/15.
//

import SwiftUI

import SDWebImageSwiftUI

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
      WebImage(url: imagePath)
        .onSuccess { image, data, cacheType in
          
        }
        .placeholder {
          MovieImagePlaceholder()
        }
        .resizable()
        .aspectRatio(contentMode: contentMode)
        .imageScale(.large)
        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
        .cornerRadius(cornerRadius)
    }
  }
}
