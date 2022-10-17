//
//  MovieCardView.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/05.
//

import ComposableArchitecture
import SwiftUI

// MARK: View

public struct MovieCardView: View {
  private var movie: Result
  private let cardCornerRadius: CGFloat = 8
  
  public init(movie: Result) {
    self.movie = movie
  }
  
  public var body: some View {
    let imagePath = Constants.posterImageURL.appendingPathComponent(movie.posterPath)
    VStack(alignment: .leading, spacing: 8) {
      VStack(spacing: 0) {
        GeometryReader { proxy in
          AsyncImage(url: imagePath) { image in
            image
              .resizable()
              .aspectRatio(0.75, contentMode: .fill)
              .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
              .cornerRadius(cardCornerRadius)
              
          } placeholder: {
            ProgressView()
              .progressViewStyle(.circular)
              .tint(.orange)
              .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
              .background(Color.black.cornerRadius(cardCornerRadius))
          }
        }
      }
      .frame(width: 150, height: 250)
      
      Text(movie.title ?? "")
        .font(.fontMaker(weight: .bold, size: 14))
        .padding([.bottom, .horizontal], 10)
    }
    .frame(maxWidth: 150)
  }
}
