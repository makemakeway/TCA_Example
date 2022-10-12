//
//  HomeView.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/09/19.
//

import ComposableArchitecture
import SwiftUI

// MARK: View

public struct HomeView: View {

  @ObservedObject
  private var viewStore: HomeViewStore

  private let store: HomeStore
  
  public init(store: HomeStore) {
    self.viewStore = ViewStore(store)
    self.store = store
  }

  public var body: some View {
    WithViewStore(self.store) { viewStore in
      List(viewStore.newMovies?.results ?? [], id: \.id) { movie in
        Text(movie.title ?? "")
      }
      .task {
        viewStore.send(.fetchNewMovies(page: 1))
      }
      .refreshable {
        viewStore.send(.fetchNewMovies(page: 1))
      }
    }
  }
}

// MARK: Store

public typealias HomeStore = Store<
  HomeState,
  HomeAction
>

// MARK: ViewStore

public typealias HomeViewStore = ViewStore<
  HomeState,
  HomeAction
>

// MARK: Preview

struct HomeView_Previews: PreviewProvider {

  static var previews: some View {
    HomeView(store: store)
      .previewLayout(.sizeThatFits)
  }

  static let store: HomeStore = .init(
    initialState: .init(),
    reducer: .init(),
    environment: .init()
  )
}
