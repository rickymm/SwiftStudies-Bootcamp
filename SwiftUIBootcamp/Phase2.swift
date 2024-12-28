//
//  Phase2.swift
//  SwiftUIBootcamp
//
//  Created by Ricky Mafra Moino on 02/12/24.
//

import SwiftUI

struct Phase2: View {
    @State var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            Color(isLoading ? .purple : .gray)
                .opacity(0.3)
                .ignoresSafeArea(edges: .all)
            
            VStack {
                ZStack {
                    Color.black
                        .shadow(radius: 4, y: 4)
                        .opacity(0.9)
                        .ignoresSafeArea()
                    
                    VStack {
                        HStack {
                            Text("Home")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Image(systemName: "person.fill")
                                .font(.title2)
                            
                        }
                        .padding()
                        .foregroundStyle(.white)
     
                        Spacer()
                    }
                    
                }
                .frame(height: UIScreen.main.bounds.height * 0.05)
                
                VStack {
                    Button("Is loading") {
                        withAnimation(.spring) {
                            isLoading.toggle()
                        }
                    }
                    .frame(width: 150, height: 50)
                    .foregroundStyle(.white)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    
                    if isLoading {
                        ProgressView()
                    }
                    
                    AnimationTest()
                        
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct AnimationTest: View {
    @State var isAnimating: Bool = false
    @State var showAnimation: Bool = false

    var body: some View {
        VStack {
            Button("Button") {
                isAnimating.toggle()
                showAnimation.toggle()
            }
            RoundedRectangle(cornerRadius: 20)
               .frame(width: isAnimating ? 350 : 50, height: 100)
               .animation(Animation.linear, value: showAnimation)
        }
    }
}

#Preview {
    Phase2()
}
