//
//  AuthService.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 28.09.2023.
//

import Foundation

protocol AuthService {
    func loadUser() -> User?
    func add(user: User)
    func clean()
}

// MARK: - Implementation

final class AuthServiceImpl: AuthService {
    
    // MARK: Properties
    
    private let key = "user"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    // MARK: LastLocationService
    
    func loadUser() -> User? {
        guard
            let data = UserDefaults.standard.object(forKey: key) as? Data,
            let user = try? decoder.decode(User.self, from: data)
        else { return nil }
        return user
    }
    
    func add(user: User) {
        clean()
        guard let data = try? encoder.encode(user) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func clean() {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}
