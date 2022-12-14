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
  private var movie: MovieResult
  private let cardCornerRadius: CGFloat = 8
  
  public init(movie: MovieResult) {
    self.movie = movie
  }
  
  public var body: some View {
    let imagePath = Constants.posterImageURL.appendingPathComponent(movie.posterPath)
    VStack(alignment: .leading, spacing: 8) {
      VStack(spacing: 0) {
        MovieCardImageView(path: imagePath.absoluteString)
      }
      .frame(width: 150, height: 250)
      
      Text(movie.title)
        .font(.fontMaker(weight: .bold, size: 14))
        .padding([.bottom, .horizontal], 10)
        .foregroundColor(.primary)
    }
    .frame(maxWidth: 150)
  }
}
