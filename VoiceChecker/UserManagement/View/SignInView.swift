//
//  SignInView.swift
//  VoiceChecker
//
//  Created by 하창진 on 3/2/24.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    
    @State private var showProgress = false
    @State private var showAlert = false
    @State private var changeView = false
    @State private var alertType: UserManagementAlertTypeModel? = nil
    
    @AppStorage("authInfo") var authInfo = ""
    
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea(.all, edges: [.top, .bottom])
            
            VStack{
                Image("ic_appstore")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                TextLogo()
                
                Spacer()
                
                Group{
                    HStack {
                        Image(systemName: "at.circle.fill")
                            .foregroundStyle(email == "" ? Color.gray : Color.accentColor)
                        
                        TextField("E-Mail", text: $email)
                    }
                    .foregroundStyle(Color.accentColor)
                    .padding(20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                    
                    Spacer().frame(height : 20)
                    
                    HStack {
                        Image(systemName: "key.fill")
                            .foregroundStyle(password == "" ? Color.gray : Color.accentColor)
                        
                        SecureField("비밀번호", text: $password)
                    }
                    .foregroundStyle(Color.accentColor)
                    .padding(20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                }
                
                Spacer()
                
                if showProgress{
                    DotProgressView()
                } else{
                    Button(action: {
                        
                    }){
                        HStack{
                            Spacer()

                            Text("로그인")
                                .foregroundStyle(Color.txt)
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.txt)
                            
                            Spacer()
                        }
                            
                    }.buttonStyle(NewMorphButtonStyle(foreground: Color.background))
                }
                
                Spacer()
                
                HStack{
                    NavigationLink(destination: EmptyView()){
                        Text("비밀번호 재설정")
                            .foregroundStyle(Color.txt)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: EmptyView()){
                        Text("회원가입")
                            .foregroundStyle(Color.txt)
                    }
                }
                
                Spacer()
                
                Text("© 2024 Changjin Ha\nAll Rights Reserved.")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.gray)
            }.padding(20)
        }
    }
}

#Preview {
    SignInView()
}
