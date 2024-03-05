//
//  FollowerView.swift
//  TakeHomeProject
//
//  Created by Berkin KOCA on 5.03.2024.
//

import SwiftUI

struct FollowerView: View {
    
    var follower: Follower
    
    var body: some View {
        
        VStack {
            AsyncImage(url: URL(string: follower.avatarUrl)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(.avatarPlaceholder)
            }
            .clipShape(Circle())
            
            
            
            Text(follower.login)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
    }
}

#Preview {
    FollowerView(follower: Follower(login: "berking27", avatarUrl: ""))
}
