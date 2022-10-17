// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topRatedMoviesModel = try? newJSONDecoder().decode(TopRatedMoviesModel.self, from: jsonData)

import Foundation

// MARK: - TopRatedMoviesModel
public struct TopRatedMoviesModel: Codable, Equatable, MovieDataImp {
  public var page: Int
  public var results: [Result]
  public var totalResults, totalPages: Int
  public var id = UUID().uuidString
  
  enum CodingKeys: String, CodingKey {
    case page, results
    case totalResults = "total_results"
    case totalPages = "total_pages"
  }
  
  public init(page: Int, results: [Result], totalResults: Int, totalPages: Int) {
    self.page = page
    self.results = results
    self.totalResults = totalResults
    self.totalPages = totalPages
  }
}
