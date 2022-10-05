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
  @ObservedObject
  private var viewStore: MovieCardViewStore
  private let store: MovieCardStore
  private let cardCornerRadius: CGFloat = 8

  public init(store: MovieCardStore) {
    self.viewStore = ViewStore(store)
    self.store = store
  }

  public var body: some View {
    ZStack {
      VStack(alignment: .leading, spacing: 8) {
        Image(systemName: "person.fill")
          .resizable()
          .background(Color.mint.cornerRadius(cardCornerRadius))
          .frame(maxWidth: Constants.width, maxHeight: Constants.width)
        Text("Title")
        Text("SUBTitle")
          .padding(.bottom, 8)
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 20)
      .background(Color.orange)
    }
  }
}

// MARK: Store

public typealias MovieCardStore = Store<
  MovieCardState,
  MovieCardAction
>

// MARK: ViewStore

public typealias MovieCardViewStore = ViewStore<
  MovieCardState,
  MovieCardAction
>

// MARK: Preview

struct MovieCardView_Previews: PreviewProvider {

  static var previews: some View {
    MovieCardView(store: store)
      .previewLayout(.sizeThatFits)
  }

  static let store: MovieCardStore = .init(
    initialState: .init(),
    reducer: .init(),
    environment: .init()
  )
}