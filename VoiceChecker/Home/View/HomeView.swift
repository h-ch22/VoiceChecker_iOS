//
//  HomeView.swift
//  VoiceChecker
//
//  Created by 하창진 on 3/3/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var helper: UserManagement
    
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea(.all, edges: [.top, .bottom])
            
            ScrollView{
                VStack{
                    HStack{
                        Text("안녕하세요,\n\(helper.userInfo?.name ?? "알 수 없는 사용자")님 😆")
                        
                        Spacer()
                    }
                    
                    
                }.padding(20)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(UserManagement())
}
