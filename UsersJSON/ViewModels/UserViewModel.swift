//
//  UserViewModel.swift
//  UsersJSON
//
//  Created by Artem Paliutin on 04/04/2022.
//

import Foundation
import Combine
import MapKit


class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 1.1, longitude: 1.1), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    
    var cancellable = Set<AnyCancellable>()
    
    init() {
        load()
    }
    
    // MARK: - Functions
    
    // MARK: load
    func load() {
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
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Completion is finished")
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] returnedUsers in
                self?.users = returnedUsers
            }
            .store(in: &cancellable)
    }
    
    // MARK: coordinateCenter
    func coordinateCenter(lat: Double, lon: Double) {
        region.center.longitude = lon
        region.center.latitude = lat
    }
    
}
