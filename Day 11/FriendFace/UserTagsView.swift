//
//  UserTagsView.swift
//  FriendFace
//
//  Created by Karina Zhang on 1/4/21.
//

import SwiftUI

struct UserTagsView: View {
    let tags: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(Capsule())
                }
            }
        }
    }
}

struct UserTagsView_Previews: PreviewProvider {
    static var previews: some View {
        UserTagsView(tags: [])
    }
}
