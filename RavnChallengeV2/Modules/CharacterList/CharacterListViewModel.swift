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
    private var endCursor: String?
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: CharacterServiceType) {
        self.service = service
        self.state = State(response: AllCharactersResponse.initial)
    }
    
    func fetchCharacters() {
        service
            .allPeople(first: API.numberOfCharacters, after: endCursor)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.state.response = response
            }).store(in: &subscriptions)
    }
    
    static func make() -> CharacterListViewModel {
        .init(service: CharacterService.make())
    }
}

extension CharacterListViewModel {
    struct State {
        var response: AllCharactersResponse
    }
}
