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
  public typealias NewMoviesResponse = (Int) async throws -> NewMoviesModel
  
  public var fetchNewMovies: NewMoviesResponse
  
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
    fetchNewMovies: { page in
      return try await MovieService.request(NewMoviesModel.self, request: MovieEndPoint.fetchNowPlaying(page: page))
    }
  )
}
