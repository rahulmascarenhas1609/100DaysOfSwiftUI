//
//  UserViewModel.swift
//  PracticeProject
//
//  Created by ZML-MAC-RahulM-01 on 02/02/26.
//

import Foundation

@MainActor
final class UserViewModel: ObservableObject {
    
    @Published var users : [User] = []
    @Published var isLoading : Bool = false
    @Published var errorMessage : String?
    
    private let service: UserServiceProtocol
    
    init(service: UserServiceProtocol = UserService()) {
        self.service = service
    }
    
    func loadUsers() async {
        isLoading = true
        errorMessage = nil
        do {
            users = try await service.fetchUsers()
        } catch {
            errorMessage = "Failed to load users"
        }
        
        isLoading = false
    }
}
