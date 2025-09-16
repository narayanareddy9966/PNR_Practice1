//
//  NetworkClient.swift
//  PNR_Practice1
//
//  Created by Pathakota Narayana Reddy on 16/09/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidUrl
    case invalidResponse
    case serverError(Int)
    case decodeError
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl: return "Invalid Url"
        case .invalidResponse: return "Invalid Response"
        case .serverError(let code): return "Server Error with code \(code)"
        case .decodeError: return "Decode Error"
        }
    }
}

protocol NetworkClient {
    func request<T: Decodable>(endpointURL: String) async throws -> T
}

final class URLSessionNetworkClient : NetworkClient {
    
    private var session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(endpointURL: String) async throws -> T {
        guard let requestUrl =  URL(string: endpointURL) else { throw NetworkError.invalidUrl}
        let (data, response) = try await session.data(for: URLRequest(url: requestUrl))
        
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else { throw NetworkError.invalidResponse}
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodeError
        }
    }
    
}
