//
//  UserListView.swift
//  PracticeProject
//
//  Created by ZML-MAC-RahulM-01 on 02/02/26.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                } else {
                    List(viewModel.users) { user in
                        Text(user.name)
                    }
                }
            }
            .navigationTitle("Users")
        }
        .task {
            await viewModel.loadUsers()
        }
    }
}

#Preview {
    UserListView()
}
