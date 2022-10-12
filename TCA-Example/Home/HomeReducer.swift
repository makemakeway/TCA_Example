//
//  HomeReducer.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/09/19.
//

import ComposableArchitecture

public typealias HomeReducer = Reducer<
  HomeState,
  HomeAction,
  HomeEnvironment
>

public extension HomeReducer {
  init() {
    self = Self
      .combine(
        .init { state, action, environment in
          switch action {
          case .fetchNewMovies(let currentPage):
            if !state.newMovieLastPageLoaded {
              return .task {
                await .newMoviesResponse(TaskResult { try await environment.movieService.fetchNewMovies(currentPage) })
              }
            } else {
              return .none
            }
          case let .newMoviesResponse(.success(movies)):
            var currentMovies = state.newMovies
            if state.newMoviePage == movies.totalPages {
              state.newMovieLastPageLoaded = true
            }
            if !currentMovies.contains(movies) {
              currentMovies.append(movies)
              state.newMoviePage = (movies.page ?? 1) + 1
              state.newMovies = currentMovies
            }
            return .none
          case let .newMoviesResponse(.failure(error)):
            print(error)
            return .none
          }
        }
      )
  }
}
