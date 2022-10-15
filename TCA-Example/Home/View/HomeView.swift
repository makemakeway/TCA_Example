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
  private var viewStore: ViewStoreOf<HomeFeature>
  
  private let store: StoreOf<HomeFeature>
  
  @State
  var currentIndex: Int = 0
  
  public init(store: StoreOf<HomeFeature>) {
    self.viewStore = ViewStore(store)
    self.store = store
//    UIView.appearance().backgroundColor = .black
  }
  
  @ViewBuilder
  private func horizontalCardSection(
    title: String,
    movies: [NowPlayingMoviesModel],
    fetchAction: HomeFeature.Action
  ) -> some View {
    Section {
      VStack(spacing: 0) {
        HStack {
          Text(title)
            .font(.fontMaker(weight: .bold, size: 20))
          Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
        
        ScrollView(.horizontal, showsIndicators: false) {
          LazyHStack(spacing: 10) {
            ForEach(viewStore.nowMovies, id: \.page) { movies in
              ForEach(movies.results ?? [], id: \.id) { movie in
                MovieCardView(movie: movie)
              }
            }
            if !viewStore.nowMovieLastPageLoaded {
              ProgressView()
                .task {
                  viewStore.send(fetchAction)
                }
            }
          }
          .padding(.horizontal, 10)
        }
      }
    }
  }
  
  public var body: some View {
    WithViewStore(self.store) { viewStore in
      ScrollView {
        Section {
          TabView(selection: $currentIndex) {
            let data = [1, 2, 3, 4, 5]
            ForEach(data, id: \.self) { _ in
              Color.mint
            }
          }
          .tabViewStyle(.page)
        }
        .frame(height: Constants.height * 0.3)
        
        horizontalCardSection(
          title: "현재 상영중",
          movies: viewStore.nowMovies,
          fetchAction: .fetchNewMovies(currentPage: viewStore.nowMoviePage)
        )
        .padding(.top, 10)
        
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
