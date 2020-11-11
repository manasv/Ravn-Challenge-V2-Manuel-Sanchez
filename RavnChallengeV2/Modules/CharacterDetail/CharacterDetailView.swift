//
//  CharacterDetailView.swift
//  RavnChallengeV2
//
//  Created by Manuel Sánchez on 11/11/20.
//

import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    CharacterDetailSectionTitleView(title: "General Information")
                    
                    CharacterDetailRowView(title: "Eye Color", value: viewModel.character.eyeColor)
                    CharacterDetailRowView(title: "Hair Color", value: viewModel.character.hairColor)
                    CharacterDetailRowView(title: "Skin Color", value: viewModel.character.skinColor)
                    CharacterDetailRowView(title: "Birth Year", value: viewModel.character.birthYear,
                                           capitalized: false)
                }
                
                if let vehicles = viewModel.character.vehicles,
                   !vehicles.isEmpty {
                    Group {
                        
                        CharacterDetailSectionTitleView(title: "Vehicles")
                        
                        ForEach(vehicles, id: \.self) { vehicle in
                            CharacterDetailRowView(title: vehicle)
                        }
                    }
                }
            }
        }.navigationTitle(viewModel.character.name)
    }
}

struct CharacterDetailSectionTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .textStyle(HeadingStyle())
            .padding([.vertical, .leading])
    }
}

struct CharacterDetailRowView: View {
    let title: String
    let value: String
    let capitalized: Bool
    
    init(title: String, value: String = "", capitalized: Bool = true) {
        self.title = title
        self.value = value
        self.capitalized = capitalized
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                HStack {
                    Text(title)
                        .textStyle(HeadingLowEmphasisStyle())
                    Spacer()
                }
                
                if !value.isEmpty {
                    HStack {
                        Spacer()
                        Text(capitalized ? value.capitalized : value)
                            .textStyle(HeadingStyle())
                    }
                }
            }.padding(.horizontal)
            
            Divider()
                .background(Color.black.opacity(0.1))
                .padding(.leading)
        }
        .frame(height: 49)
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(viewModel: CharacterDetailViewModel(character: Mock.singleCharacter))
    }
}
