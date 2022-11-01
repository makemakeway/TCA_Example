//
//  MovieDataImp.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/17.
//

import Foundation

public protocol MovieDataImp: Identifiable, Codable {
  var results: [Result] { get set }
  var page: Int { get set }
  var totalPages: Int { get set }
  var totalResults: Int { get set }
  var id: String { get set }
}

//public extension MovieDataImp {
//  public func hash(into hasher: inout Hasher) {
//    hasher.combine()
//  }
//}
