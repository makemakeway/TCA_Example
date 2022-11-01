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
    public var nowMovies: [CommonMoviesModel] = []
    public var nowMoviePage: Int = 1
    public var nowMovieLastPageLoaded: Bool = false
    
    public var upcomingMovies: [UpcomingMovie] = []
    public var upcomingPage: Int = 1
    
    public var topRatedMovies: [TopRatedMoviesModel] = []
    public var topRatedPage: Int = 1
    public var topRateMovieLastPageLoaded: Bool = false
    
    public var popularMovies: [CommonMoviesModel] = []
    public var popularMoviesPage: Int = 1
    public var popularMovieLastPageLoaded: Bool = false
    
    public var initailized: Bool = false
    
    public init() {
      
    }
  }
  
  public enum Action: Equatable {
    case fetchNewMovies(currentPage: Int)
    case fetchTopRatedMovies(currentPage: Int)
    case fetchUpcommingMovies(currentPage: Int)
    case fetchPopularMovies(currentPage: Int)
    case newMoviesResponse(TaskResult<CommonMoviesModel>)
    case upcomingMoviesResponse(TaskResult<UpcomingMovie>)
    case topRatedMoviesResponse(TaskResult<TopRatedMoviesModel>)
    case popularMoviesResponse(TaskResult<CommonMoviesModel>)
    case homeInit
    case endInit
  }
  
  
  public var body: some ReducerProtocol<State, Action> {
    Reduce(self.core(into:action:))
    
  }
  
  public func core(into state: inout State, action: Action) -> Effect<Action, Never> {
    switch action {
    case .homeInit:
      if state.initailized {
        return .none
      } else {
        return .run { send in
          await send(.fetchTopRatedMovies(currentPage: 1))
          await send(.fetchNewMovies(currentPage: 1))
          await send(.fetchPopularMovies(currentPage: 1))
          await send(.fetchUpcommingMovies(currentPage: 1))
          await send(.endInit)
        }
      }
    case .endInit:
      state.initailized = true
      return .none
    case .fetchNewMovies(let currentPage):
      if !state.nowMovieLastPageLoaded {
        return .run { send in
          await send(.newMoviesResponse(TaskResult { try await movieService.fetchNowPlayingMovies(currentPage) }))
        }
      } else {
        return .none
      }
    case .fetchUpcommingMovies(let page):
      return .run(priority: .userInitiated) { send in
        await send(.upcomingMoviesResponse(TaskResult { try await movieService.fetchUpcomingMovies(page) }))
      }
    case .fetchTopRatedMovies(currentPage: let page):
      if !state.topRateMovieLastPageLoaded {
        return .run { send in
          await send(.topRatedMoviesResponse(TaskResult { try await movieService.fetchTopRatedMovies(page) }))
        }
      } else {
        return .none
      }
    case .topRatedMoviesResponse(.failure(let error)):
      print("DEBUG: TOP RATED MOVIE FETCH FAILED... \(error.localizedDescription)")
      return .none
    case .topRatedMoviesResponse(.success(let movies)):
      var currentMovies = state.topRatedMovies
      if state.topRatedPage == movies.totalPages {
        state.topRateMovieLastPageLoaded = true
      }
      if !currentMovies.contains(movies) {
        currentMovies.append(movies)
        state.topRatedPage = (movies.page) + 1
        state.topRatedMovies = currentMovies
      }
      return .none
    case let .newMoviesResponse(.success(movies)):
      var currentMovies = state.nowMovies
      if state.nowMoviePage == movies.totalPages {
        state.nowMovieLastPageLoaded = true
      }
      if !currentMovies.contains(movies) {
        currentMovies.append(movies)
        state.nowMoviePage = (movies.page) + 1
        state.nowMovies = currentMovies
      }
      return .none
    case let .newMoviesResponse(.failure(error)):
      print(error)
      return .none
    case let .upcomingMoviesResponse(.success(movie)):
      var current = state.upcomingMovies
      if !current.contains(movie) {
        current.append(movie)
      }
      state.upcomingMovies = current
      print("DEBUG: \(state.upcomingMovies.count)")
      return .none
    case .upcomingMoviesResponse(.failure):
      return .none
    case let .fetchPopularMovies(page):
      return .task {
        await .popularMoviesResponse(TaskResult { try await movieService.fetchPopularMovies(page) })
      }
    case let .popularMoviesResponse(.success(movie)):
      var current = state.popularMovies
      if !current.contains(movie) {
        current.append(movie)
      }
      state.popularMovies = current
      return .none
    case let .popularMoviesResponse(.failure(error)):
      print("DEBUG: POPULAR MOVIE FETCH FAILED... \(error.localizedDescription)")
      return .none
    }
      
  }
}
