//
//  NetworkingManager.swift
//  UsersJSON
//
//  Created by Artem Paliutin on 06/04/2022.
//

import Foundation
import Combine

class NetworkingManager {
    
    // MARK: - NetworkingError
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
               return "[⚠️] Bad response from URL: \(url)"
            case .unknown:
               return "[⚠️] Unknown error"
            }
        }
        
    }
    
    // MARK: - download
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output: $0, url: url )})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: - handleURLResponse
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
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

