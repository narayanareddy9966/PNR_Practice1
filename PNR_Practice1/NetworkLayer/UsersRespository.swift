//
//  UsersRespository.swift
//  PNR_Practice1
//
//  Created by Pathakota Narayana Reddy on 16/09/25.
//

import Foundation

protocol UsersRespository {
    func getUsers() async throws -> [User]
}

final class UserRepositoryImpl: UsersRespository {

    private var userClient: NetworkClient
    private var endpoint: String
    init(userClient: NetworkClient = URLSessionNetworkClient(), endpoint: String = "https://jsonplaceholder.typicode.com/users") {
        self.userClient = userClient
        self.endpoint = endpoint
    }
    
    func getUsers() async throws -> [User] {
        return try await userClient.request(endpointURL: endpoint)
    }
}




final class MockUserRepository: UsersRespository {

    private var result: Result<[User], Error>
    init(result: Result<[User], Error>) {
        self.result = result
    }
    
    func getUsers() async throws -> [User] {
        switch result {
        case .success(let users): return users
        case .failure(let error): throw error
        }
    }
    
}

