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

  public init(store: MovieCardStore) {
    self.viewStore = ViewStore(store)
    self.store = store
  }

  public var body: some View {
    ZStack {
      VStack(alignment: .leading, spacing: 0) {
        Image(systemName: "person.fill")
          .resizable()
          .background(Color.mint)
          .frame(width: UIScreen.main.bounds.width, height: 400)
        
        Text("Title")
        Text("SUBTitle")
      }
      .padding(.horizontal, 10)
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
