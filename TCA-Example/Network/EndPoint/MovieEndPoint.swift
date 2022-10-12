//
//  EndPoint.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/11.
//

import Foundation

import Alamofire

public enum MovieEndPoint: URLRequestConvertible {
  case fetchNewMovies(page: Int)
  case searchMovie(query: String, page: Int)
  case fetchMovieDetail(ID: Int)
  case fetchMovieGenreList
  
  private var method: HTTPMethod {
    switch self {
    case .fetchNewMovies, .searchMovie, .fetchMovieGenreList, .fetchMovieDetail:
      return .get
    }
  }
  
  private var path: String {
    let baseURL = MovieAPIConstants.baseURL.absoluteString
    switch self {
    case let .fetchMovieDetail(id):
      return baseURL + "/movie"
    case let .fetchNewMovies(page):
      return baseURL + "/movie/now_playing"
    case let .searchMovie(query, page):
      return baseURL + "/search/movie"
    case .fetchMovieGenreList:
      return baseURL + "/genre/movie/list"
    }
  }
  
  private var parameters: Parameters? {
    switch self {
    case let .fetchMovieDetail(ID: id):
      return ["movie_id":id]
    case let .searchMovie(query: query, page: page):
      return ["query":query, "page":page]
    case let .fetchNewMovies(page: page):
      return ["page":page]
    case .fetchMovieGenreList:
      return nil
    }
  }
  
  private var encoding: ParameterEncoding {
    switch self {
    case .fetchNewMovies, .fetchMovieDetail, .searchMovie:
      return URLEncoding.queryString
    case .fetchMovieGenreList:
      return URLEncoding.default
    }
  }
  
  public func asURLRequest() throws -> URLRequest {
    let url = try path.asURL().appending("api_key", value: MovieAPIConstants.key)
    print(url)
    var request = URLRequest(url: url)
    request.method = self.method
    request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    return request
  }
}

public struct MovieAPIConstants {
  // MARK: Base URL
  public static var baseURL: URL {
    URL(string: "https://api.themoviedb.org/3")!
  }
  
  public static var key: String {
    return Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
  }
  
  // MARK: Headers
  public static var headers: [String : String]? {
    return ["Content-type": "application/json"]
  }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
