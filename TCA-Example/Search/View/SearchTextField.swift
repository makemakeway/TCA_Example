//
//  SearchTextField.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/17.
//

import SwiftUI

import ComposableArchitecture

public struct SearchTextField: View {
  @ObservedObject
  public var viewStore: SearchViewStore
  
  public init(viewStore: SearchViewStore) {
    self.viewStore = viewStore
  }
  
  public var body: some View {
    HStack {
      TextField("", text: viewStore.binding(get: \.searchText, send: SearchFeature.Action.searchTextDidChange))
      
      Spacer()
      
      Image(systemName: "magnifyingglass")
    }
  }
}
