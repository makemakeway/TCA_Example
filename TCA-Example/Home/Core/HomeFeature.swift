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
    public var nowMovies: [NowPlayingMoviesModel] = []
    public var nowMoviePage: Int = 1
    public var nowMovieLastPageLoaded: Bool = false
    
    public var upcomingMovies: [UpcomingMovie] = []
    
    public init() {
      
    }
  }
  
  public enum Action: Equatable {
    case fetchNewMovies(currentPage: Int)
    case newMoviesResponse(TaskResult<NowPlayingMoviesModel>)
    case upcomingMoviesResponse(TaskResult<UpcomingMovie>)
  }
  
  public func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
    switch action {
    case .fetchNewMovies(let currentPage):
      if !state.nowMovieLastPageLoaded {
        return .task {
          await .newMoviesResponse(TaskResult { try await movieService.fetchNowPlayingMovies(currentPage) })
          
        }
      } else {
        return .none
      }
    case let .newMoviesResponse(.success(movies)):
      var currentMovies = state.nowMovies
      if state.nowMoviePage == movies.totalPages {
        state.nowMovieLastPageLoaded = true
      }
      if !currentMovies.contains(movies) {
        currentMovies.append(movies)
        state.nowMoviePage = (movies.page ?? 1) + 1
        state.nowMovies = currentMovies
      }
      return .none
    case let .newMoviesResponse(.failure(error)):
      print(error)
      return .none
    case let .upcomingMoviesResponse(.success(movie)):
      
      return .none
    case .upcomingMoviesResponse(.failure):
      return .none
    }
  }
}
