//
//  MovieService.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/11.
//

import Foundation

import Alamofire
import ComposableArchitecture

public enum MovieError: String, Error {
  case some
}

public struct MovieService {
  public typealias NowPlayingMoviesResponse = (Int) async throws -> CommonMoviesModel
  public typealias UpcomingMoviesResponse = (Int) async throws -> UpcomingMovie
  public typealias TopRatedMoivesResponse = (Int) async throws -> TopRatedMoviesModel
  public typealias PopularMoviesResponse = (Int) async throws -> CommonMoviesModel
  
  public var fetchNowPlayingMovies: NowPlayingMoviesResponse
  public var fetchUpcomingMovies: UpcomingMoviesResponse
  public var fetchTopRatedMovies: TopRatedMoivesResponse
  public var fetchPopularMovies: PopularMoviesResponse
  
  static func request<T: Decodable>(
    _ object: T.Type,
    request: URLRequestConvertible
  ) async throws -> T {
    return try await AF.request(request)
      .serializingDecodable()
      .value
  }
}

extension MovieService {
  static let live = Self(
    fetchNowPlayingMovies: { page in
      return try await MovieService.request(CommonMoviesModel.self, request: MovieEndPoint.fetchNowPlaying(page: page))
    },
    fetchUpcomingMovies: { page in
      return try await MovieService.request(UpcomingMovie.self, request: MovieEndPoint.fetchUpcomingMovies(page: page))
    },
    fetchTopRatedMovies: { page in
      return try await MovieService.request(TopRatedMoviesModel.self, request: MovieEndPoint.fetchTopRatedMovies(page: page))
    },
    fetchPopularMovies: { page in
      return try await MovieService.request(CommonMoviesModel.self, request: MovieEndPoint.fetchPopularMovies(page: page))
    }
  )
}
