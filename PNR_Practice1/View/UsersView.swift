//
//  UsersView.swift
//  PNR_Practice1
//
//  Created by Pathakota Narayana Reddy on 16/09/25.
//

import SwiftUI

struct UsersView: View {
    @StateObject private var userViewModel: UserViewModel
    init(repository: UsersRespository) {
        _userViewModel = StateObject(wrappedValue: UserViewModel(repository: repository))
    }
    var body: some View {
        NavigationView {
            Group {
                VStack {
                    if userViewModel.isLoading {
                        ProgressView("Loading...")
                    } else if let error = userViewModel.errorMessage {
                        Text(error).foregroundColor(.red)
                    } else {
                        List(userViewModel.users) { user in
                            VStack {
                                Text(user.name)
                            }
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await userViewModel.loadUsers()
                }
            }
            .navigationTitle("Users")
        }
    }
}

#Preview {
    UsersView(repository: UserRepositoryImpl())
}
