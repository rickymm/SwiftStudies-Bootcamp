//
//  BottomCard.swift
//  SwiftUIBootcamp
//
//  Created by Ricky Mafra Moino on 02/12/24.
//

import SwiftUI

struct BottomCard: View {
    @State var isShowing: Bool = false
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1))
                .ignoresSafeArea()
            
            Circle()
                .frame(width: 300, height: 300)
                .shadow(color: Color(#colorLiteral(red: 0.9647058824, green: 0.9450980392, blue: 0.8352941176, alpha: 1)), radius: 60)
                .foregroundColor(Color(#colorLiteral(red: 0.9647058824, green: 0.9450980392, blue: 0.8352941176, alpha: 1)))
          
            
            VStack {
                Spacer()
                
                Button("Show") {
                    isShowing.toggle()
                }
                .sheet(isPresented: $isShowing) {
                    SheetContent()
                }
            
            }
            
        }
    }
}

struct SheetContent: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.purple
                .ignoresSafeArea()
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
            }
            .padding()
            .foregroundColor(.white)
            .font(.title2)
        }
        
    }
}

#Preview {
    BottomCard()
}
