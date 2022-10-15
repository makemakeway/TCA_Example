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
  
  public init(store: StoreOf<HomeFeature>) {
    self.viewStore = ViewStore(store)
    self.store = store
  }
  
  @ViewBuilder
  private func horizontalCardSection(
    title: String,
    movies: [NewMoviesModel],
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
            ForEach(viewStore.newMovies, id: \.page) { movies in
              ForEach(movies.results ?? [], id: \.id) { movie in
                MovieCardView(movie: movie)
              }
            }
            if !viewStore.newMovieLastPageLoaded {
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
        horizontalCardSection(
          title: "현재 상영중",
          movies: viewStore.newMovies,
          fetchAction: .fetchNewMovies(currentPage: viewStore.newMoviePage)
        )
        
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
