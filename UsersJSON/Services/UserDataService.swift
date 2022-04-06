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
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (output) -> Data in
                guard
                    let response = output.response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [User].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Completion finished")
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] returnedUsers in
                self?.users = returnedUsers
            }
            .store(in: &cancellable)

    }
}
