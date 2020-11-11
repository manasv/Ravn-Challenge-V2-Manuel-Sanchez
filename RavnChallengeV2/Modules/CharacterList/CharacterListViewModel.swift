//
//  CharacterListViewModel.swift
//  RavnChallengeV2
//
//  Created by Manuel Sánchez on 11/11/20.
//

import Foundation
import Combine

final class CharacterListViewModel: ObservableObject {
    @Published var state: State
    
    private let service: CharacterServiceType
    private let reachability: ReachabilityServiceType
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: CharacterServiceType = CharacterService.make(),
         reachability: ReachabilityServiceType = ReachabilityService.make(),
         characters: [StarWarsCharacter] = []) {
        self.service = service
        self.reachability = reachability
        self.state = State(response: AllCharactersResponse.initial, characters: characters)
    }
    
    func fetchCharacters() {
        if reachability.serviceStarted, reachability.networkIsReachable {
            fetchAllCharacters()
        } else if reachability.serviceStarted, !reachability.networkIsReachable {
            state.loadDidFail()
        } else {
            reachability.configure()
            fetchAllCharacters()
        }
    }
    
    private func fetchAllCharacters() {
        state.isLoading = true
        
        service
            .allPeople(first: API.numberOfCharacters, after: state.response.pageInfo.endCursor)
            .sink(receiveCompletion: { [weak self] result in
                self?.state.isLoading = false
                
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                    print("Failed")
                    self?.state.loadDidFail()
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.saveResponse(response)
            }).store(in: &subscriptions)
    }
    
    func paginateIfPosible(after character: StarWarsCharacter) {
        if !state.isLoading,
           state.response.pageInfo.hasNextPage,
           state.characters.last?.id == character.id {
            fetchCharacters()
        }
    }
    
    private func saveResponse(_ response: AllCharactersResponse) {
        let responseCharacters = response.characters.map { character -> StarWarsCharacter in
            var vehicles: [String]?
            
            if let vehicleConnection = character.vehicleConnection,
               let responseVehicles = vehicleConnection.vehicles {
                vehicles = responseVehicles.compactMap({ $0?.name })
            }
            
            return StarWarsCharacter(id: character.id,
                                     name: character.name ?? "",
                                     hairColor: character.hairColor ?? "",
                                     eyeColor: character.eyeColor ?? "",
                                     skinColor: character.skinColor ?? "",
                                     birthYear: character.birthYear ?? "",
                                     species: character.species?.name,
                                     homeWorld: character.homeworld?.name ?? "",
                                     vehicles: vehicles)
        }
        
        self.state.characters.append(contentsOf: responseCharacters)
        self.state.response.pageInfo = response.pageInfo
        self.state.loadingFailed = false
    }
    
    static func make() -> CharacterListViewModel {
        .init(service: CharacterService.make(), reachability: ReachabilityService())
    }
}

extension CharacterListViewModel {
    struct State {
        var response: AllCharactersResponse
        var characters: [StarWarsCharacter]
        var isLoading = false
        var loadingFailed = false
        
        mutating func loadDidFail() {
            isLoading = false
            loadingFailed = true
        }
    }
}
