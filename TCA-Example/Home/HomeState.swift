//
//  HomeState.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/09/19.
//

public struct HomeState: Equatable {
  public var newMovies: [NewMoviesModel] = []
  public var newMoviePage: Int = 1
  public var newMovieLastPageLoaded: Bool = false
  
  public init() {
    
  }
}
