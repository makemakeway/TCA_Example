//
//  HomeView.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/09/19.
//

import ComposableArchitecture
import SwiftUI
import SDWebImageSwiftUI

// MARK: View

public struct HomeView: View {
  @ObservedObject
  private var viewStore: ViewStoreOf<HomeFeature>
  private let store: StoreOf<HomeFeature>
  
  @State
  var currentIndex: Int = 0
  @State
  var currentPopularPage: Int = 0
  
  public init(store: StoreOf<HomeFeature>) {
    self.viewStore = ViewStore(store)
    self.store = store
    viewStore.send(.homeInit)
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
//                NavigationLink(value: Result.self) {
                  MovieCardView(movie: movie)
//                }
              }
            }
            if !viewStore.nowMovieLastPageLoaded && !movies.isEmpty {
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

  
  private func makeRow(movies: [any MovieDataImp]) -> [[(Result, Int)]] {
    var items: [[(Result, Int)]] = []
    var currentRow: [(Result, Int)] = []
    
    movies.forEach { results in
      results.results.enumerated().forEach { result in
        currentRow.append((result.element, result.offset))
        if currentRow.count == 5 {
          items.append(currentRow)
          currentRow.removeAll()
        }
      }
    }
    if !currentRow.isEmpty {
      items.append(currentRow)
      currentRow.removeAll()
    }
  
    return items
  }
  
  @ViewBuilder
  private func rowsCardSection(title: String, movies: [any MovieDataImp]) -> some View {
    let rows = makeRow(movies: movies)
    
    VStack(spacing: 0) {
      HStack {
        Text(title)
          .font(.fontMaker(weight: .bold, size: 20))
        Spacer()
      }
      .padding(.horizontal, 20)
      if !movies.isEmpty {
        TabView {
          ForEach(rows.indices, id: \.self) { firstIndex in
            VStack {
              ForEach(rows[firstIndex], id: \.1) { (result, index) in
                HStack(alignment: .top, spacing: 0) {
                  MovieCardImageView(path: result.posterPath)
                    .frame(width: 60, height: 80)
                    .padding(.horizontal, 10)
                  Text("\(index + 1)")
                    .font(.fontMaker(weight: .bold, size: 18))
                    .padding(.trailing, 8)
                  Text(result.title)
                    .font(.fontMaker(weight: .regular, size: 16))
                  Spacer()
                }
              }
            }
          }
        }
        .frame(height: 500)
        .padding(.horizontal, 20)
        .tabViewStyle(.page(indexDisplayMode: .never))
      }
      else {
        //TODO: PlaceHolder
        Text("비어있슴")
      }
    }
  }
  
  public var body: some View {
    WithViewStore(self.store) { viewStore in
      ScrollView {
        //MARK: upcoming movies
        Section {
          if !viewStore.upcomingMovies.isEmpty {
            TabView(selection: $currentIndex) {
              ForEach(viewStore.upcomingMovies, id: \.id) { movies in
                ForEach(movies.results, id: \.id) { movie in
                  MovieCardImageView(path: movie.posterPath, contentMode: .fill)
                }
              }
            }
            .tabViewStyle(.page)
          }
        }
        .frame(height: Constants.height * 0.7)
        
        horizontalCardSection(
          title: "현재 상영중인 영화 👀",
          movies: viewStore.nowMovies,
          fetchAction: .fetchNewMovies(currentPage: viewStore.nowMoviePage)
        )
        .padding(.vertical, 20)
        
        horizontalCardSection(
          title: "띵작 영화 모음 💪",
          movies: viewStore.popularMovies,
          fetchAction: .fetchTopRatedMovies(currentPage: viewStore.popularMoviesPage)
        )
        .padding(.vertical, 20)
        
        rowsCardSection(title: "평점 TOP 100 📈", movies: viewStore.topRatedMovies)
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
