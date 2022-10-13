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
      ScrollView {
        Section {
          VStack(spacing: 0) {
            HStack {
              Text("현재 상영중")
                .font(.fontMaker(weight: .bold, size: 20))
              Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
              LazyHStack(spacing: 10) {
                ForEach(viewStore.newMovies, id: \.page) { movies in
                  ForEach(movies.results ?? [], id: \.id) { movie in
                    MovieCardView(movie: movie)
                  }
                }
                if !viewStore.newMovieLastPageLoaded {
                  ProgressView()
                    .task {
                      print("FETCH \(viewStore.newMoviePage)PAGE")
                      viewStore.send(.fetchNewMovies(currentPage: viewStore.newMoviePage))
                    }
                }
              }
              .padding(.horizontal, 10)
            }
          }
        }
        
        Section {
          
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .principal) {
          Text("Movie Database")
            .font(.fontMaker(weight: .bold, size: 18))
        }
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
