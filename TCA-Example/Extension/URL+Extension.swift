//
//  URL+Extension.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/11.
//

import Foundation

public extension URL {
  func appending(_ queryItem: String, value: String?) -> URL {
    guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
    var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
    let queryItem = URLQueryItem(name: queryItem, value: value)
    queryItems.insert(queryItem, at: 0)
    urlComponents.queryItems = queryItems
    return urlComponents.url!
  }
}
