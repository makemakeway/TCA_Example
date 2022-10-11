//
//  MovieService.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/11.
//

import Foundation

import Moya

public struct MovieService {
  static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
  static let provider = MoyaProvider<MovieEndPoint>()
}
