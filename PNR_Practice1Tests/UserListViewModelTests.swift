//
//  UserListViewModelTests.swift
//  PNR_Practice1Tests
//
//  Created by Pathakota Narayana Reddy on 16/09/25.
//

import XCTest
@testable import PNR_Practice1

final class UserListViewModelTests: XCTestCase {

    func test_loadUser_success() async throws {
            let sut =  await UserViewModel(repository: MockUserRepository(result: .success([User(id: 1, name: "Alice", username: "alice123", email: "alice@mail.com", phone: "123", website: "alice.com", address: Address(street: "1st", suite: "A", city: "NY", zipcode: "10001"), company: Company(name: "ACME", catchPhrase: "Test", bs: "biz"))])))
           
            await sut.loadUsers()
            
            await MainActor.run {
                XCTAssertTrue(sut.isLoading)
                XCTAssertNil(sut.errorMessage)
                XCTAssertEqual(sut.users.count, 1)
                XCTAssertEqual((sut.users.first as! User as User).name, "Alice")
            }

    }
    
    func test_loadUsers_failure() async {
        let mockRepo = MockUserRepository(result: .failure(NSError(domain: "TestError", code: 1)))
        let vm = await UserViewModel(repository: mockRepo)
        await vm.loadUsers()
        
        await MainActor.run {
            XCTAssertFalse(vm.isLoading)
            XCTAssertNotNil(vm.errorMessage)
            XCTAssertTrue(vm.users.isEmpty)
        }

    }

}


