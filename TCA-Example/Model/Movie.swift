//
//  NewMoviesModel.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/12.
//

import Foundation

public struct NewMoviesModel: Codable,Equatable {
  public var dates: MoviesDates?
  public var page: Int?
  public var results: [MovieModel]?
  public var totalPages, totalResults: Int?
  
  enum CodingKeys: String, CodingKey {
    case dates, page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

extension NewMoviesModel {
  init(data: Data) throws {
    let decoder = JSONDecoder()
    self = try decoder.decode(NewMoviesModel.self, from: data)
  }
}

public struct MoviesDates: Codable,Equatable {
  public var maximum, minimum: String?
}

public struct MovieModel: Codable,Equatable {
  public var adult: Bool?
  public var backdropPath: String?
  public var genreids: [Int]?
  public var id: Int?
  public var originalLanguage, originalTitle, overview: String?
  public var popularity: Double?
  public var posterPath, releaseDate, title: String?
  public var video: Bool?
  public var voteAverage: Double?
  public var voteCount: Int?
  
  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case genreids = "genre_ids"
    case id
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview, popularity
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case title, video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}
