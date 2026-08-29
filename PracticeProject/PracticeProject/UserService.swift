//
//  UserService.swift
//  PracticeProject
//
//  Created by ZML-MAC-RahulM-01 on 02/02/26.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUsers() async throws-> [User]
}

final class UserService: UserServiceProtocol {
    private let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
    
    func fetchUsers() async throws -> [User] {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([User].self, from: data)
    }
}
