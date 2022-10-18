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
  }
  
  @ViewBuilder
  private func horizontalCardSection(
    title: String,
    movies: [any MovieDataImp],
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
            ForEach(movies, id: \.id) { movies in
              ForEach(movies.results, id: \.id) { movie in
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
  
  @ViewBuilder
  private func rowsCardSection(title: String, movies: [any MovieDataImp], fetchAction: HomeFeature.Action) -> some View {
    TabView {
      
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
  }
  
  public var body: some View {
    WithViewStore(self.store) { viewStore in
      ScrollView {
        Section {
          TabView(selection: $currentIndex) {
            if viewStore.upcomingMovies.isEmpty {
              Color(uiColor: .darkGray)
            } else {
              ForEach(viewStore.upcomingMovies, id: \.id) { movies in
                ForEach(movies.results, id: \.id) { movie in
                  MovieCardImageView(path: movie.posterPath, contentMode: .fill)
                }
              }
            }
          }
          .tabViewStyle(.page)
          .task {
            viewStore.send(.fetchUpcommingMovies(currentPage: 1))
          }
        }
        .frame(height: Constants.height * 0.3)
        
        horizontalCardSection(
          title: "현재 상영중",
          movies: viewStore.nowMovies,
          fetchAction: .fetchNewMovies(currentPage: viewStore.nowMoviePage)
        )
        .padding(.vertical, 10)
        
        horizontalCardSection(
          title: "평점 좋은 영화",
          movies: viewStore.topRatedMovies,
          fetchAction: .fetchTopRatedMovies(currentPage: viewStore.topRatedPage)
        )
        .padding(.vertical, 10)
        
        horizontalCardSection(
          title: "요즘 뜨는 영화",
          movies: viewStore.popularMovies,
          fetchAction: .fetchPopularMovies(currentPage: viewStore.popularMoviesPage)
        )
      }
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .principal) {
          Text("Movie DB")
            .font(.fontMaker(weight: .bold, size: 18))
        }
      }
    }
  }
}
