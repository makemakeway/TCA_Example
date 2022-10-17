//
//  SearchView.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/17.
//

import SwiftUI

import ComposableArchitecture

public struct SearchView: View {
  public var store: SearchStore
  @ObservedObject public var viewStore: SearchViewStore
  
  public init(store: SearchStore) {
    self.store = store
    self.viewStore = ViewStore(store)
  }
  
  public var body: some View {
    ScrollView {
      
    }
    .toolbar {
      ToolbarItem(placement: .principal) {
        SearchTextField(viewStore: viewStore)
      }
    }
  }
}
