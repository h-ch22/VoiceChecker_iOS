//
//  Logos.swift
//  VoiceChecker
//
//  Created by 하창진 on 3/3/24.
//

import SwiftUI

struct TextLogo: View {
    var body: some View {
        Text("**Voice** Checker")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .foregroundStyle(Color.txt)
    }
}

struct TextLogoRegular: View {
    var body: some View {
        Text("**Voice** Checker")
    }
}

struct TextWithImageLogo: View{
    var body: some View{
        HStack{
            Image("ic_appstore")
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            
            Text("**Voice** Checker")
                .font(.title2)
                .foregroundStyle(Color.txt)

        }
    }
}

struct TextWithImageLogo_Vertical: View{
    var body: some View{
        VStack{
            Image("ic_appstore")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            
            Text("**Voice** Checker")
                .font(.title2)
                .foregroundStyle(Color.txt)

        }
    }
}

#Preview("TextLogo") {
    TextLogo()
}

#Preview("TextWithImageLogo"){
    TextWithImageLogo()
}

#Preview("TextWithImageLogo_Vertical"){
    TextWithImageLogo_Vertical()
}
