//
//  TitleView.swift
//  BlackJack
//
//  Created by mai chieu thuy on 01/09/2023.
//

import SwiftUI

struct TitleView: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack {
            Text(text)
                .bold()
                .font(.custom("Poppins-Medium", size: 20))
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.top, 64)
        .padding(.horizontal)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView("BlackJack")
    }
}
