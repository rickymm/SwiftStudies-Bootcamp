//
//  ListObjects.swift
//  SwiftUIBootcamp
//
//  Created by Ricky Mafra Moino on 16/12/24.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID()
    let name: String
    let username: String
    let followers: Int
    let isVerified: Bool
}

class UserViewModel: ObservableObject {
    @Published var users: [UserModel] = []
    @Published var isLoading: Bool = false
    
    init() {
        getUsers()
    }
    
    func getUsers() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.users = [
                UserModel(name: "Ricky", username: "rickymafra", followers: 657, isVerified: true),
                UserModel(name: "Rudge", username: "de_moino", followers: 346, isVerified: false),
                UserModel(name: "Regis", username: "regismoino", followers: 478, isVerified: true),
            ]
            self.isLoading = false
        }
    }
    
}

struct ObjectsList: View {
    // Ideally that should've been put into EnvironmentObject
    @StateObject var userViewModel = UserViewModel()
  
    var body: some View {
        NavigationView {
            List {
                if userViewModel.isLoading {
                    ProgressView()
                } else {
                    ForEach(userViewModel.users) { user in
                        // With EnvironmentObject we wouldn't need to pass down userViewModel
                        NavigationLink(destination: UserProfile(userId: user.id, userViewModel: userViewModel)) {
                            HStack {
                                Circle()
                                    .frame(width: 35, height: 35)
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(user.name)
                                            .font(.headline)
                                        
                                        if user.isVerified {
                                            Image(systemName: "checkmark.seal.fill")
                                                .frame(width: 15, height: 15)
                                                .foregroundStyle(.blue)
                                        }
                                    }
                                    Text("@\(user.username)")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                    
                                }
                                
                                
                                Spacer()
                                
                                VStack {
                                    Text("\(user.followers)")
                                        .font(.headline)
                                    Text("Followers")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                
                            }
                            .padding(.vertical, 10)
                        }
                    }
                }
            }
            .navigationTitle("Following")
        }
    }
}

struct UserProfile: View {
    var userId: UUID
    // Could've been EnvironmentObject
    @ObservedObject var userViewModel: UserViewModel
    private var user: UserModel? {
        userViewModel.users.first(where: { $0.id == userId })
    }

    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 1), count: 3)
    
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Circle()
                    .foregroundStyle(.white)
                    .frame(width: 200, height: 200)
                
                HStack {
                    Text(user?.name ?? "")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    if user?.isVerified == true {
                        Image(systemName: "checkmark.seal.fill")
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.blue)
                    }
                }
                .padding(.top)
                
            
                Text("@\(user?.username ?? "") - \(user?.followers ?? 0) followers")
                    .font(.caption)
                    .foregroundStyle(.white)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(0..<30, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundStyle(.white)
                                .frame(width: (UIScreen.main.bounds.width / 3) - 10, height: (((UIScreen.main.bounds.width / 3) * 4) / 3) - 10)
                                .padding(.horizontal)
                        
                        }
                    }
                }
                .padding(.top)
                
                Spacer()
            }
        }
    }
}

#Preview {
    ObjectsList()
}
