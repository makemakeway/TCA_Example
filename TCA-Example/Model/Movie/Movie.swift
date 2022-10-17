//
//  NewMoviesModel.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/12.
//

import Foundation

public struct CommonMoviesModel: Codable, Equatable, MovieDataImp {
  public var dates: MoviesDates
  public var page: Int
  public var results: [Result]
  public var totalPages, totalResults: Int
  public var id = UUID().uuidString
  
  enum CodingKeys: String, CodingKey {
    case dates, page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

extension CommonMoviesModel {
  init(data: Data) throws {
    let decoder = JSONDecoder()
    self = try decoder.decode(CommonMoviesModel.self, from: data)
  }
}

public struct MoviesDates: Codable,Equatable {
  public var maximum, minimum: String?
}
