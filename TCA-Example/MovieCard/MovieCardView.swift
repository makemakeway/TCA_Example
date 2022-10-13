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
  private var movie: MovieModel
  private let cardCornerRadius: CGFloat = 8
  
  public init(movie: MovieModel) {
    self.movie = movie
  }
  
  public var body: some View {
    let imagePath = Constants.posterImageURL.appendingPathComponent(movie.posterPath ?? "")
    VStack(alignment: .leading, spacing: 8) {
      AsyncImage(url: imagePath) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
          .cornerRadius(cardCornerRadius)
          .frame(width: 200, height: 200)
      } placeholder: {
        Image(systemName: "photo.fill")
          .resizable()
          .frame(width: 200, height: 200)
      }

      Text(movie.title ?? "")
        .font(.fontMaker(weight: .bold, size: 18))
        .foregroundColor(.black)
      Text(movie.originalTitle ?? "")
        .padding(.bottom, 8)
        .font(.fontMaker(weight: .semibold, size: 16))
        .foregroundColor(.black)
    }
    .padding([.horizontal, .top], 10)
    .background(
      RoundedRectangle(cornerRadius: cardCornerRadius)
        .stroke(.black, lineWidth: 1)
    )
  }
}

// MARK: Preview

struct MovieCardView_Previews: PreviewProvider {
  
  static var previews: some View {
    MovieCardView(movie: MovieModel(originalTitle: "test", title: "zz"))
      .previewLayout(.sizeThatFits)
  }
}
