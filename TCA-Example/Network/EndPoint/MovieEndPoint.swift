//
//  EndPoint.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/11.
//

import Foundation

import Alamofire

public enum MovieEndPoint: URLRequestConvertible {
  case fetchNowPlaying(page: Int)
  case searchMovie(query: String, page: Int)
  case fetchMovieDetail(ID: Int)
  case fetchMovieGenreList
  case fetchUpcomingMovies(page: Int)
  case fetchTopRatedMovies(page: Int)
  
  private var method: HTTPMethod {
    switch self {
    default:
      return .get
    }
  }
  
  private var path: String {
    let baseURL = MovieAPIConstants.baseURL.absoluteString
    switch self {
    case .fetchMovieDetail:
      return baseURL + "/movie"
    case .fetchNowPlaying:
      return baseURL + "/movie/now_playing"
    case .searchMovie:
      return baseURL + "/search/movie"
    case .fetchMovieGenreList:
      return baseURL + "/genre/movie/list"
    case .fetchUpcomingMovies:
      return baseURL + "/movie/upcoming"
    case .fetchTopRatedMovies:
      return baseURL + "/movie/top_rated"
    }
  }
  
  private var parameters: Parameters? {
    switch self {
    case let .fetchMovieDetail(ID: id):
      return ["movie_id":id]
    case let .searchMovie(query: query, page: page):
      return ["query":query, "page":page]
    case let .fetchNowPlaying(page: page):
      return ["page":page, "language":"ko-KR"] // LANGUAGE
    case let .fetchUpcomingMovies(page: page):
      return ["page":page, "language":"ko-KR", "region":"KOR"]
    case let .fetchTopRatedMovies(page: page):
      return ["page":page, "language":"ko-KR"]
    default:
      return ["language":"ko-KR"]
    }
  }
  
  private var encoding: ParameterEncoding {
    switch self {
    case .fetchNowPlaying, .fetchMovieDetail, .searchMovie, .fetchTopRatedMovies:
      return URLEncoding.queryString
    default:
      return URLEncoding.default
    }
  }
  
  public func asURLRequest() throws -> URLRequest {
    let url = try path.asURL().appending("api_key", value: MovieAPIConstants.key)
    var request = URLRequest(url: url)
    request.method = self.method
    request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    
    if let parameters = parameters {
      return try encoding.encode(request, with: parameters)
    }
    
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
