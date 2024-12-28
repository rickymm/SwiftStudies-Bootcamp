//
//  HomeView.swift
//  SwiftUIBootcamp
//
//  Created by Ricky Mafra Moino on 21/12/24.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("user_name") var currentUsername: String = ""
    @AppStorage("amount") var currentAmount: Double?
    @AppStorage("manual") var currentManual: Bool = false
    @AppStorage("is_signed") var currentIsSigned: Bool = false
    
    let imageUrl = URL(string: "https://picsum.photos/400")
    
    var body: some View {
        VStack {
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                case .empty: // loading
                    ProgressView()
                        .frame(width: 200, height: 200)
                case .success(let returnedImage):
                    returnedImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                case .failure(let error):
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
                default:
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
                }
                
            }
            

            
            Text("**User:** \(currentUsername)")
            Text("**Salary:** $\(String(format: "%.2f", currentAmount ?? 0))")
            
            
            Toggle(isOn: $currentManual) {
                Text("**Is manual?**")
            }
            .disabled(true)
            .frame(width: 200)
            
            Button("Sign out") {
                signout()
            }
            .foregroundStyle(.red)
            .padding()
            
        }
        .foregroundStyle(Color.white)
    }
    
    func signout() {
        currentUsername = ""
        currentAmount = nil
        currentManual = false
        currentIsSigned = false
    }
}

#Preview {
    HomeView()
        .background(.black)
}
