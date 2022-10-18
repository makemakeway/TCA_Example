//
//  DetailView.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/18.
//

import SwiftUI

import ComposableArchitecture

public struct DatailView: View {
  public let store: DetailStore
  @ObservedObject
  private var viewStore: DetailViewStore
  
  public init(store: DetailStore) {
    self.store = store
    self.viewStore = ViewStore(store)
  }
  
  public var body: some View {
    Text("DETAIL")
  }
}

public typealias DetailStore = StoreOf<DetailFeature>
public typealias DetailViewStore = ViewStoreOf<DetailFeature>
