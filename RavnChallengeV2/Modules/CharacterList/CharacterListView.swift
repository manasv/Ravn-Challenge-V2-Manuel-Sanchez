//
//  CharacterListView.swift
//  RavnChallengeV2
//
//  Created by Manuel Sánchez on 10/11/20.
//

import SwiftUI

struct CharacterListView: View {
    @ObservedObject var viewModel: CharacterListViewModel
    
    var body: some View {
        LazyVStack {
            ForEach(viewModel.state.response.characters, id: \.id) { character in
                Text(character.name ?? "Nil")
            }
        }.onAppear(perform: {
            viewModel.fetchCharacters()
        })
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(viewModel: CharacterListViewModel.make())
    }
}
