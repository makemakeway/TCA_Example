//
//  EndPoint.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/11.
//

import Foundation
import Moya

public enum MovieEndPoint {
  case fetchNewMovies(page: Int)
  case searchMovie(query: String, page: Int)
  case fetchMovieDetail(ID: Int)
  case fetchMovieGenreList
}

extension MovieEndPoint: TargetType {
  // MARK: Base URL
  public var baseURL: URL {
    URL(string: "https://api.themoviedb.org/3") ?? URL(string: "https://naver.com")!
  }
  
  // MARK: PATH
  public var path: String {
    switch self {
    case .fetchMovieDetail:
      return "/movie"
    case .fetchMovieGenreList:
      return "/genre/movie/list"
    case .fetchNewMovies:
      return "/movie/now_playing"
    case .searchMovie:
      return "/search/movie"
    }
  }
  
  // MARK: Moya Method
  public var method: Moya.Method {
    switch self {
    case .searchMovie, .fetchNewMovies, .fetchMovieGenreList, .fetchMovieDetail:
      return .get
    }
  }
  
  // MARK: Task Configuration
  public var task: Moya.Task {
    switch self {
    case let .fetchMovieDetail(ID: id):
      return .requestParameters(parameters: ["movie_id":id], encoding: URLEncoding.queryString)
    case let .searchMovie(query: query, page: page):
      return .requestParameters(parameters: ["query":query, "page":page], encoding: URLEncoding.queryString)
    case let .fetchNewMovies(page: page):
      return .requestParameters(parameters: ["page":page], encoding: URLEncoding.queryString)
    case .fetchMovieGenreList:
      return .requestPlain
    }
  }
  
  // MARK: Headers
  public var headers: [String : String]? {
    return ["Content-type": "application/json"]
  }
}
