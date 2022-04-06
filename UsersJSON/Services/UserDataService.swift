//
//  UserDataService.swift
//  UsersJSON
//
//  Created by Artem Paliutin on 06/04/2022.
//

import Foundation
import Combine


class UserDataService {
    @Published var users: [User] = []
    var cancellable = Set<AnyCancellable>()
    
    
    init() {
        getUsers()
    }
    
    private func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/") else { return }
        
        NetworkingManager.download(url: url)
            .decode(type: [User].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedUser in
                self?.users = returnedUser
            })
            
            .store(in: &cancellable)
    }
    
}
