//
//  HomeAction.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/09/19.
//

import Foundation

import ComposableArchitecture

public enum HomeAction: Equatable {
  case fetchNewMovies(page: Int)
  case newMoviesResponse(TaskResult<NewMoviesModel>)
}
