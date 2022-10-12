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
          case let .fetchNewMovies(page):
            return .task {
              await .newMoviesResponse(TaskResult { try await environment.movieService.fetchNewMovies(page) })
            }
          case let .newMoviesResponse(.success(movies)):
            state.newMovies = movies
            return .none
          case let .newMoviesResponse(.failure(error)):
            print(error)
            return .none
          }
        }
      )
  }
}
