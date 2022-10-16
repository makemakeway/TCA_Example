//
//  UpcomingBanner.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/15.
//

import SwiftUI

import ComposableArchitecture

public struct UpcomingBanner: View {
  
  
  public init(viewStore: ViewStoreOf<HomeFeature>) {
    viewStore.send(.fetchUpcommingMovies(currentPage: 1))
  }
  
  public var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}
