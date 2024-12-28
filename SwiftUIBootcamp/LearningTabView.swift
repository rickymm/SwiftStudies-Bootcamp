//
//  LearningTabView.swift
//  SwiftUIBootcamp
//
//  Created by Ricky Mafra Moino on 12/12/24.
//

import SwiftUI

struct LearningTabView: View {
    @State var selectedView = 3
    
    var body: some View {
        TabView(selection: $selectedView) {
            Tab("Instagram", systemImage: "globe", value: 0) {
                InstagramPost()
            }
            
            Tab("Home", systemImage: "house.fill", value: 1) {
                Crud()
            }
            
            Tab("Card", systemImage: "simcard", value: 2) {
                BottomCard()
            }
            
            Tab("Profile", systemImage: "person.fill", value: 3) {
                FormWithTextFields(selectedTab: $selectedView)
            }
        }
    }
}

#Preview {
    LearningTabView()
}
