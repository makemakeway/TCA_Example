//
//  HomeFeature.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/15.
//

import Foundation

import ComposableArchitecture

public struct HomeFeature: ReducerProtocol {
  let movieService = MovieService.live
  
  public init() {}
  public struct State: Equatable {
    public var newMovies: [NewMoviesModel] = []
    public var newMoviePage: Int = 1
    public var newMovieLastPageLoaded: Bool = false
    
    public init() {
      
    }
  }
  
  public enum Action: Equatable {
    case fetchNewMovies(currentPage: Int)
    case newMoviesResponse(TaskResult<NewMoviesModel>)
  }
  
  public func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
    switch action {
    case .fetchNewMovies(let currentPage):
      if !state.newMovieLastPageLoaded {
        return .task {
          await .newMoviesResponse(TaskResult { try await movieService.fetchNewMovies(currentPage) })
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
}
