//
//  InstagramPost.swift
//  SwiftUIBootcamp
//
//  Created by Ricky Mafra Moino on 08/12/24.
//

import SwiftUI

struct InstagramPost: View {
    @State var showSendMenu: Bool = false
    @State var showPostActions: Bool = false
    @State var actionType: ActionType = .isOthersPost
    @State var likedPost: Bool = false
    @State var showTapLike: Bool = false
    
    enum ActionType {
        case isMyPost
        case isOthersPost
    }
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 30, height: 30)
            
                Text("@username")
                Image(systemName: "checkmark.seal.fill")
                    .foregroundStyle(.blue)
                
                Spacer()
                
                Button {
                    showPostActions.toggle()
                } label: {
                    Image(systemName: "ellipsis")
                }
                .foregroundStyle(.primary)
                .contextMenu {
                    getActions()
                }
                
            }
            .padding(.horizontal)
            .confirmationDialog(
                "Actions:",
                isPresented: $showPostActions,
                actions: getActions
            )
            
            ZStack {
                TabView {
                    Rectangle()
                    
                    Rectangle()
                        .foregroundStyle(.pink)
                    
                    Rectangle()
                        .foregroundStyle(.purple)
                }
                .tabViewStyle(PageTabViewStyle())
                .aspectRatio(1.0, contentMode: .fit)
                .onTapGesture(count: 2) {
                    likedPost.toggle()
                    showLike()
                }
                
//                if showTapLike {
                    Image(systemName: likedPost ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 62, height: 60)
                        .foregroundStyle(likedPost ? Color.red : Color.white)
                        .opacity(showTapLike ? 1 : 0)
                        .animation(Animation.easeInOut(duration: 0.2), value: showTapLike)
//                }
            }
            
            HStack {
                Button {
                    likedPost.toggle()
                } label: {
                    Image(systemName: likedPost ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 22, height: 20)
                }
                .foregroundStyle(likedPost ? .red : .primary)

                Text("1,987")
                    .padding(.trailing)
                
                Image(systemName: "bubble")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("458")
                
                Spacer()
                
                Button {
                    actionType = .isMyPost
                    showSendMenu.toggle()
                } label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .foregroundStyle(.primary)
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
        }
        .confirmationDialog(
            "Actions",
            isPresented: $showSendMenu
        ) {
            VStack(alignment: .leading) {
                Button {} label: {
                    Text("John Doe @jhonnyd")
                }
                Button {} label: {
                    Text("Gaby Folk @gfolky")
                }
            }
        } message: {
            Text("Share to:")
        }
    }
  
    
    func getActions() -> some View {
        VStack {
            Button {} label: {
                Label("Share", systemImage: "paperplane")
            }
            
            if actionType == .isOthersPost {
                Button(role: .destructive) {} label: {
                    Label("Report", systemImage: "exclamationmark.bubble")
                }
            }
            
            if actionType == .isMyPost {
                Button(role: .destructive) {} label: {
                    Label("Report", systemImage: "eraser.fill")
                }
            }
        }
    }
    
    
    func showLike() -> Void {
        showTapLike = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            showTapLike = false
        }
    }
}

#Preview {
    InstagramPost()
}
