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
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 1.1, longitude: 1.1), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    
    private let dataService = UserDataService()
    var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    // MARK: - Functions
    // MARK: addSubscribers
    func addSubscribers() {
        dataService.$users
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
    
    // MARK: filterUser
    func filterUser() {
        $search
            .combineLatest($users)
            .map { (text, user) -> [User] in
                guard !text.isEmpty else {
                    return user
                }
                let lowercasedText = text.lowercased()
                return user.filter { user in
                    return user.username.lowercased().contains(lowercasedText)
                }
                
            }
            .sink { [weak self] returnUsers in
                self?.users = returnUsers
            }
            .store(in: &cancellable)
    }
    

    
}
