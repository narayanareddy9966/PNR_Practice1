//
//  UserViewModel.swift
//  PNR_Practice1
//
//  Created by Pathakota Narayana Reddy on 16/09/25.
//

import Foundation

@MainActor
final class UserViewModel: ObservableObject {
    private var repository: UsersRespository
    init(repository: UsersRespository) {
        self.repository = repository
    }
    
    @Published var users:[User] = []
    @Published var isLoading =  false
    @Published var errorMessage: String?
    
    func loadUsers() async {
        self.isLoading = false
        do {
            self.isLoading = true
            self.users = try await repository.getUsers()
        } catch {
            self.errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
        }
        self.isLoading = false
    }
    
}
