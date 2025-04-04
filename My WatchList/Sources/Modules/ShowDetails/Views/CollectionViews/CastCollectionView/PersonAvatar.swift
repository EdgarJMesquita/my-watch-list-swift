//
//  PersonAvatar.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 17/03/25.
//

import Foundation
import SwiftUI

struct PersonAvatar: View {
    let name: String
    let urlString: String
    
    var body: some View {
        VStack {
            if let url = URL(string: urlString) {
                AsyncImage(url: url) {
                    $0.image?.resizable().scaledToFit()
                }
                .frame(width: 70,height: 70)
                .clipShape(Circle())
            }
            Text(name)
                .fontWeight(.semibold)
                .foregroundStyle(.mwlTitle)
            
        }
    }
}


#Preview {
    PersonAvatar(
    name: "Ed", urlString: "https://github.com/EdgarJMesquita.png")
}
