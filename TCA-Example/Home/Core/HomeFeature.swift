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
    
    public init() {
      
    }
  }
  
  public enum Action: Equatable {
    case fetchNewMovies(currentPage: Int)
    case fetchTopRatedMovies(currentPage: Int)
    case fetchUpcommingMovies(currentPage: Int)
    case newMoviesResponse(TaskResult<CommonMoviesModel>)
    case upcomingMoviesResponse(TaskResult<UpcomingMovie>)
    case topRatedMoviesResponse(TaskResult<TopRatedMoviesModel>)
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
    case .fetchUpcommingMovies(let page):
      return .task(priority: .userInitiated) {
        await .upcomingMoviesResponse(TaskResult { try await movieService.fetchUpcomingMovies(page) })
      }
    case .fetchTopRatedMovies(currentPage: let page):
      return .task {
        await .topRatedMoviesResponse(TaskResult { try await movieService.fetchTopRatedMovies(page) })
      }
    case .topRatedMoviesResponse(.failure(let error)):
      print("DEBUG: TOP RATED MOVIE FETCH FAILED... \(error.localizedDescription)")
      return .none
    case .topRatedMoviesResponse(.success(let movies)):
      print("DEBUG: \(movies)")
      state.topRatedMovies = [movies]
      return .none
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
      print("DEBUG: \(movie)")
      var current = state.upcomingMovies
      current.append(movie)
      state.upcomingMovies = current
      return .none
    case .upcomingMoviesResponse(.failure):
      return .none
    }
  }
}
