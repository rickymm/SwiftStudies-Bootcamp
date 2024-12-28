//
//  OnAppearCounter.swift
//  SwiftUIBootcamp
//
//  Created by Ricky Mafra Moino on 14/12/24.
//

import SwiftUI

struct OnAppearCounter: View {
    @State var count: Int = 0
    @State var isLoading: Bool = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text(isLoading ? "Loading..." : "Done!")
                if !isLoading {
                    RectanglesList
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    isLoading = false
                }
            }
            .navigationTitle("On Appear: \(count)")
        }
    }
    
    var RectanglesList: some View {
        LazyVStack(spacing: 20) {
            ForEach(0..<50) { _ in
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: 200)
                    .onAppear {
                        count += 1
                    }
            }
        }
        .padding()
    }
}

#Preview {
    OnAppearCounter()
}
