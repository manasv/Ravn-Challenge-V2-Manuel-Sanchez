//
//  NavigationBarColor.swift
//  RavnChallengeV2
//
//  Created by Manuel Sánchez on 11/11/20.
//

import SwiftUI
import UIKit

struct NavigationBarColor: ViewModifier {
  init(backgroundColor: UIColor, tintColor: UIColor) {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = backgroundColor
    appearance.titleTextAttributes = [.foregroundColor: tintColor]
    appearance.largeTitleTextAttributes = [.foregroundColor: tintColor]
                   
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().compactAppearance = appearance
    UINavigationBar.appearance().tintColor = tintColor
  }

  func body(content: Content) -> some View {
    content
  }
}
