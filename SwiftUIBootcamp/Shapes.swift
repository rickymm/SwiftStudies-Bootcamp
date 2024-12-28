//
//  Shapes.swift
//  SwiftUIBootcamp
//
//  Created by Ricky Mafra Moino on 27/11/24.
//

import SwiftUI

struct Shapes: View {
    @State var isTapped = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color(UIColor.secondarySystemFill))
                .cornerRadius(25.0)
                .frame(width: 350, height: 250)
//                .shadow(radius: 20)
                .shadow(color: Color.purple, radius: 20)
                .padding(.bottom, 50)
            
            ZStack {
                Text("Is tapped: \(isTapped)")
                    .foregroundStyle(
//                        Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
                        Color("CustomColor")
                    )
                    .shadow(radius: 20)
                    .background(
                        Capsule()
                            .frame(width: 200, height: 100)
                            .foregroundStyle(isTapped ? Color.secondary : Color.primary)
                    )
                    .onTapGesture {
                        isTapped.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isTapped.toggle()
                        }
                    }
            }
            
        }

    }
}

#Preview {
    Shapes()
}
