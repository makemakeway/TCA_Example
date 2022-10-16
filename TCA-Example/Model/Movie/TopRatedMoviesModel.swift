// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topRatedMoviesModel = try? newJSONDecoder().decode(TopRatedMoviesModel.self, from: jsonData)

import Foundation

// MARK: - TopRatedMoviesModel
public struct TopRatedMoviesModel: Codable, Identifiable, Equatable {
  public let page: Int
  public let results: [TopRatedMovieResult]
  public let totalResults, totalPages: Int
  public let id = UUID().uuidString
  
  enum CodingKeys: String, CodingKey {
    case page, results
    case totalResults = "total_results"
    case totalPages = "total_pages"
  }
  
  public init(page: Int, results: [TopRatedMovieResult], totalResults: Int, totalPages: Int) {
    self.page = page
    self.results = results
    self.totalResults = totalResults
    self.totalPages = totalPages
  }
}

// MARK: - Result
public struct TopRatedMovieResult: Codable, Equatable {
  public let posterPath: String
  public let adult: Bool
  public let overview, releaseDate: String
  public let genreIDS: [Int]
  public let id: Int
  public let originalTitle: String
  public let originalLanguage: String
  public let title, backdropPath: String
  public let popularity: Double
  public let voteCount: Int
  public let video: Bool
  public let voteAverage: Double
  
  enum CodingKeys: String, CodingKey {
    case posterPath = "poster_path"
    case adult, overview
    case releaseDate = "release_date"
    case genreIDS = "genre_ids"
    case id
    case originalTitle = "original_title"
    case originalLanguage = "original_language"
    case title
    case backdropPath = "backdrop_path"
    case popularity
    case voteCount = "vote_count"
    case video
    case voteAverage = "vote_average"
  }
  
  public init(posterPath: String, adult: Bool, overview: String, releaseDate: String, genreIDS: [Int], id: Int, originalTitle: String, originalLanguage: String, title: String, backdropPath: String, popularity: Double, voteCount: Int, video: Bool, voteAverage: Double) {
    self.posterPath = posterPath
    self.adult = adult
    self.overview = overview
    self.releaseDate = releaseDate
    self.genreIDS = genreIDS
    self.id = id
    self.originalTitle = originalTitle
    self.originalLanguage = originalLanguage
    self.title = title
    self.backdropPath = backdropPath
    self.popularity = popularity
    self.voteCount = voteCount
    self.video = video
    self.voteAverage = voteAverage
  }
}
