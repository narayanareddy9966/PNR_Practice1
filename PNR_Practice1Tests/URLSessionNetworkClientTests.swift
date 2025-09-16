//
//  URLSessionNetworkClientTests.swift
//  PNR_Practice1Tests
//
//  Created by Pathakota Narayana Reddy on 16/09/25.
//

import XCTest
@testable import PNR_Practice1
final class URLSessionNetworkClientTests: XCTestCase {
    private var sut: NetworkClient?
    private var users: [User]?
    override func setUp() async throws {
        sut = URLSessionNetworkClient()
    }
    func test_invalidURL() async throws {
        do {
            users = try await sut?.request(endpointURL: "https://jsonplaceholder.typicode.com/usersss")
        } catch{
//            let  description = (error as? NetworkError)?.localizedDescription
//            let  description1 = (error as? LocalizedError)?.localizedDescription
            
            XCTAssertNotNil(error.localizedDescription)
        }
        

    }

}
