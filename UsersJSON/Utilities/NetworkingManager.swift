//
//  NetworkingManager.swift
//  UsersJSON
//
//  Created by Artem Paliutin on 06/04/2022.
//

import Foundation
import Combine

class NetworkingManager {
    // MARK: - download
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (output) -> Data in
                guard
                    let response = output.response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: - handleCompletion
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            print("Completion finished")
        case .failure(let error):
            print("Error \(error.localizedDescription)")
        }
    }
}

