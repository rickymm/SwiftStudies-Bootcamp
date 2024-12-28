//
//  DatingAppView.swift
//  SwiftUIBootcamp
//
//  Created by Ricky Mafra Moino on 20/12/24.
//

import SwiftUI

struct MainView: View {
    @AppStorage("is_signed") var userIsSigned = false
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)), Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))]),
                center: .topLeading,
                startRadius: 10,
                endRadius: UIScreen.main.bounds.height
            )
            .ignoresSafeArea()
            
            if userIsSigned {
                // Main Page
                HomeView()
            } else {
                // Onboarding
                OnboardingView()
            }
        }
    }
}

#Preview {
    MainView()
}
