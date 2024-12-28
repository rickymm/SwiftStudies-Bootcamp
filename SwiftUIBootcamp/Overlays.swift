//
//  Overlays.swift
//  SwiftUIBootcamp
//
//  Created by Ricky Mafra Moino on 30/11/24.
//

import SwiftUI

struct Overlays: View {
    @State var counter: Int = 0
    
    let notificationColor: Color
    let buttonIcon: Icon
    
    init(_ buttonIcon: Icon) {
        self.buttonIcon = buttonIcon
        
        if buttonIcon == .heartFill {
            self.notificationColor = .blue
        } else {
            self.notificationColor = .red
        }
    }
    
    enum Icon: String, Codable {
        case heartFill = "heart.fill"
        case heart = "heart"
    }
    
    var body: some View {
        VStack {
            Button {
                counter += 1
            } label: {
                Image(systemName: "\(buttonIcon.rawValue)")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .frame(width: 120, height: 120)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color(#colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1)), Color(#colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1))],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .shadow(color: Color(#colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 0.7045951995)), radius: 10, x: 0, y: 10)
                            .overlay(alignment: .bottomTrailing) {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(notificationColor)
                                    .shadow(color: Color(#colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 0.7045951995)), radius: 10, x: 5, y: 5)
                                    .overlay() {
                                        Text("\(counter)")
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color.white)
                                    }
                            }
                    )
                    .padding(.bottom, 60)
            }
            Text("Like button")
                .font(.callout)
        }
    }
}

#Preview {
    Overlays(.heartFill)
}
