//
//  MoviePlugin.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/11.
//

import Foundation

import Moya

public struct MoviePlugin: PluginType {
  let key: String
  
  public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    var request = request
    request.url = request.url?.appending("api_key", value: key)
    request.url = request.url?.appending("language", value: Locale.preferredLanguages.first ?? "ko-KR")
    return request
  }
}
