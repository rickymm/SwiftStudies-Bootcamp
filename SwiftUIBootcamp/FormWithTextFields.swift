//
//  TextField.swift
//  SwiftUIBootcamp
//
//  Created by Ricky Mafra Moino on 08/12/24.
//

import SwiftUI

struct FormWithTextFields: View {
    @Binding var selectedTab: Int
    
    @State var username: String = ""
    @State var password: String = ""
    @State var signupSheet: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Username")
                    .font(.callout)
                TextField("Username", text: $username)
                    .padding()
                    .background(.gray.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Text("Password")
                    .font(.callout)
                    .padding(.top, 4)
                SecureField("Password", text: $password)
                    .padding()
                    .background(.gray.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Button {
                    selectedTab = 1
                } label: {
                    Text("Submit")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.top)
                
                HStack {
                    Spacer()
                    Text("or")
                        .font(.caption)
                    Button {
                        signupSheet.toggle()
                    } label: {
                        Text("signup")
                    }
                    Spacer()
                }
                
                Spacer()
                
            }
            .padding()
            .navigationTitle("Welcome")
            .sheet(isPresented: $signupSheet) {
                SignupSheet()
            }
        }
    }
}

struct SignupSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""
    @State private var dateOfBirth: Date = Date()
    
    @State private var isSame: Bool? = nil
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                Spacer()
            }
            .padding(.bottom, 16)
            
            
            Text("Signup")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(alignment: .leading) {
                Text("Email")
                    .font(.callout)
                TextField("Email", text: $email)
                    .padding()
                    .background(.gray.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Text("Password")
                    .font(.callout)
                    .padding(.top, 4)
                SecureField("Password", text: $password)
                    .padding()
                    .background(.gray.opacity(0.05), in: RoundedRectangle(cornerRadius: 8))
                
                Text("Confirm Password")
                    .font(.callout)
                    .padding(.top, 4)
                SecureField("Confirm Password",text: $passwordConfirmation)
                    .padding()
                    .background(.gray.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                if isSame == true {
                    Text("Passwords don't match")
                        .foregroundStyle(.red)
                }
                
                DatePicker(
                    selection: $dateOfBirth,
                    in: ...Date(),
                    displayedComponents: .date
                ) {
                    Text("Date of Birth")
                        .font(.callout)
                        .padding(.top, 4)
                }
                
            }
            
            Spacer()
            
            Button {
                validateAndRegister()
            } label: {
                Text("Register")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(.blue, in: RoundedRectangle(cornerRadius: 8))
            .padding(.top)
        }
        .padding()
    }
    
    func validateAndRegister() {
        guard password == passwordConfirmation else {
            isSame = false
            return
        }
        
    }
}

#Preview {
    @Previewable @State var selectedTab = 2
    FormWithTextFields(selectedTab: $selectedTab)
//    SignupSheet()
}
