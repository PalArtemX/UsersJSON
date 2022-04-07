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
    
    @Published var search = ""
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 1.1, longitude: 1.1),
        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    
    var cancellable = Set<AnyCancellable>()
    
    private let dataService = UserDataService()
    
    init() {
        addSubscribers()
    }
    
    // MARK: - Functions
    // MARK: addSubscribers
    func addSubscribers() {
        
        // Search and update all Users
        $search
            .combineLatest(dataService.$users)
            .map(filterCoins)
            .sink { [weak self] returnedUsers in
                self?.users = returnedUsers
            }
            .store(in: &cancellable)
    }
    
    // MARK: coordinateCenter
    func coordinateCenter(lat: Double, lon: Double) {
        region.center.longitude = lon
        region.center.latitude = lat
    }
    
    
    
    // MARK: filterCoins
    private func filterCoins(text: String, users: [User]) -> [User] {
        guard !text.isEmpty else {
            return users
        }
        let lowercasedText = text.lowercased()
        return users.filter { user in
            return user.username.lowercased().contains(lowercasedText)
        }
    }
}
