//
//  RavnChallengeV2App.swift
//  RavnChallengeV2
//
//  Created by Manuel Sánchez on 10/11/20.
//

import SwiftUI

@main
struct RavnChallengeV2App: App {
    var body: some Scene {
        WindowGroup {
            CharacterListView(viewModel: CharacterListViewModel.make())
        }
    }
}
