//
//  UsersRepositoryests.swift
//  PNR_Practice1Tests
//
//  Created by Pathakota Narayana Reddy on 16/09/25.
//

import XCTest
@testable import PNR_Practice1
final class UsersRepositoryests: XCTestCase {

    private var sut: UserRepositoryImpl!
    override func setUp() {
        sut = UserRepositoryImpl(userClient: URLSessionNetworkClient(session: URLSession.shared))
    }
    
    func test_fetchUsers_success() async throws {
       let users = try await sut.getUsers()
        XCTAssertTrue(users.count == 10)
    }
       /*
       override func setUp() {
           super.setUp()
           let config = URLSessionConfiguration.ephemeral
           config.protocolClasses = [MockURLProtocol.self]
           session = URLSession(configuration: config)
           
           let client = URLSessionNetworkClient(session: session)
           sut = UserRepositoryImpl(userClient: client)
       }
       
       func test_fetchUsers_success() async throws {
           let sampleJSON = """
           [{
               "id": 1,
               "name": "Leanne Graham",
               "username": "Bret",
               "email": "Sincere@april.biz",
               "phone": "1-770-736-8031",
               "website": "hildegard.org",
               "address": {"street": "Kulas Light","suite": "Apt. 556","city": "Gwenborough","zipcode": "92998-3874"},
               "company": {"name": "Romaguera-Crona","catchPhrase": "Multi-layered client-server neural-net","bs": "harness real-time e-markets"}
           }]
           """
           
           MockURLProtocol.requestHandler = { _ in
               let response = HTTPURLResponse(url: URL(string: "https://jsonplaceholder.typicode.com/users")!,
                                              statusCode: 200, httpVersion: nil, headerFields: nil)!
               return (response, sampleJSON.data(using: .utf8)!)
           }
           
           let users = try await sut.getUsers()
           
           XCTAssertEqual(users.count, 1)
           XCTAssertEqual(users.first?.name, "Leanne Graham")
           XCTAssertEqual(users.first?.company.name, "Romaguera-Crona")
       }
*/


}


final class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("Handler not set")
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
}
