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
        NavigationView {
            List {
                ForEach(viewModel.state.characters, id: \.id) { character in
                    NavigationLink(
                        destination: CharacterDetailView(
                            viewModel: CharacterDetailViewModel(character: character)
                        ),
                        label: {
                            CharacterListElementView(character: character)
                                .onAppear(perform: {
                                    viewModel.paginateIfPosible(after: character)
                                })
                        })
                }

                if viewModel.state.isLoading {
                    LoadingView()
                }
                
                if viewModel.state.loadingFailed {
                    FailedLoadView()
                        .onAppear(perform: {
                            if viewModel.state.characters.isEmpty {
                                viewModel.fetchCharacters()
                            } else {
                                guard let lastCharacter = viewModel.state.characters.last else {
                                    return
                                }
                                
                                viewModel.paginateIfPosible(after: lastCharacter)
                            }
                        })
                }
            }
            .onAppear(perform: {
                viewModel.fetchCharacters()
            })
            .navigationBarTitle("People", displayMode: .inline)
            .modifier(
                NavigationBarColor(backgroundColor: UIColor(named: ColorName.ravnBlack) ?? .black,
                                   tintColor: .white)
            )
        }
    }
}

struct CharacterListElementView: View {
    let character: StarWarsCharacter
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(character.name)
                .textStyle(HeadingStyle())
            
            Text(character.origin)
                .textStyle(ParagraphLowEmphasisStyle())
        }.frame(height: 69)
    }
}

struct LoadingView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
            
            Text("Loading")
                .textStyle(HeadingLowEmphasisStyle())
            Spacer()
        }
    }
}

struct FailedLoadView: View {
    var body: some View {
        HStack(spacing: 16) {
            Spacer()
            Text("Failed to Load Data")
                .textStyle(HeadingHighEmphasisStyle())
            Spacer()
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(viewModel: CharacterListViewModel.make())
    }
}
