// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let upcommingMovie = try? newJSONDecoder().decode(UpcommingMovie.self, from: jsonData)

import Foundation

// MARK: - UpcommingMovie
public struct UpcomingMovie: Codable, Equatable, MovieDataImp {
  public var page: Int
  public var results: [Result]
  public var dates: Dates
  public var totalPages, totalResults: Int
  public var id = UUID().uuidString
  
  enum CodingKeys: String, CodingKey {
    case page, results, dates
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
  
  public init(page: Int, results: [Result], dates: Dates, totalPages: Int, totalResults: Int) {
    self.page = page
    self.results = results
    self.dates = dates
    self.totalPages = totalPages
    self.totalResults = totalResults
  }
}

// MARK: - Dates
public struct Dates: Codable, Equatable {
  public let maximum, minimum: String
  
  public init(maximum: String, minimum: String) {
    self.maximum = maximum
    self.minimum = minimum
  }
}

// MARK: - Result
public struct Result: Codable, Equatable {
  public let posterPath: String
  public let adult: Bool
  public let overview, releaseDate: String
  public let genreIDS: [Int]
  public let id: Int
  public let originalTitle, originalLanguage, title: String
  public let backdropPath: String?
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
  
  public init(posterPath: String, adult: Bool, overview: String, releaseDate: String, genreIDS: [Int], id: Int, originalTitle: String, originalLanguage: String, title: String, backdropPath: String?, popularity: Double, voteCount: Int, video: Bool, voteAverage: Double) {
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
