//
//  SignUpView.swift
//  VoiceChecker
//
//  Created by 하창진 on 3/3/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var checkPassword = ""
    @State private var name = ""
    @State private var phone = ""
    @State private var nickName = ""
    @State private var isEULAAccepcted = false
    @State private var isPrivacyLicenseAccepted = false
    
    @State private var showProgress = false
    @State private var showAlert = false
    @State private var changeView = false
    @State private var alertType: UserManagementAlertTypeModel? = nil
    
    @StateObject private var helper = UserManagement()
    @AppStorage("authInfo") var authInfo = ""
    
    private func getEmptyFields() -> Bool{
        return (email == "" || password == "" || checkPassword == "" || name == "" || phone == "" || nickName == "" || !isEULAAccepcted || !isPrivacyLicenseAccepted) ? true : false
    }
    
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea(.all, edges: [.top, .bottom])
            
            ScrollView{
                VStack{
                    Group{
                        HStack {
                            Image(systemName: "at.circle.fill")
                                .foregroundStyle(email == "" ? Color.gray : Color.accent)
                            
                            TextField("E-Mail", text: $email)
                                .keyboardType(.emailAddress)
                        }
                        .foregroundStyle(Color.accent)
                        .padding(20)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 5)
                        
                        Spacer().frame(height: 20)
                        
                        HStack {
                            Image(systemName: "key.fill")
                                .foregroundStyle(password == "" ? Color.gray : Color.accent)
                            
                            SecureField("비밀번호", text: $password)
                        }
                        .foregroundStyle(Color.accent)
                        .padding(20)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 5)
                        
                        Spacer().frame(height: 20)
                        
                        HStack {
                            Image(systemName: "key.fill")
                                .foregroundStyle(checkPassword == "" ? Color.gray : Color.accent)
                            
                            SecureField("비밀번호 확인", text: $checkPassword)
                        }
                        .foregroundStyle(Color.accent)
                        .padding(20)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 5)
                        
                        Spacer().frame(height: 20)
                        
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundStyle(name == "" ? Color.gray : Color.accent)
                            
                            TextField("이름", text: $name)
                        }
                        .foregroundStyle(Color.accent)
                        .padding(20)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 5)
                        
                        Spacer().frame(height: 20)
                        
                        HStack {
                            Image(systemName: "phone.fill")
                                .foregroundStyle(phone == "" ? Color.gray : Color.accent)
                            
                            TextField("연락처", text: $phone)
                                .keyboardType(.phonePad)
                        }
                        .foregroundStyle(Color.accent)
                        .padding(20)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 5)
                        
                        Spacer().frame(height: 20)
                        
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundStyle(nickName == "" ? Color.gray : Color.accent)
                            
                            TextField("닉네임", text: $nickName)
                        }
                        .foregroundStyle(Color.accent)
                        .padding(20)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 5)
                        
                        Spacer().frame(height: 20)
                        
                        HStack{
                            CheckBox(isChecked: $isEULAAccepcted, title: "최종 사용권 계약")
                            
                            Spacer()
                            
                            Button(action: {}){
                                Text("읽기")
                            }
                        }
                        
                        Spacer().frame(height: 10)
                        
                        HStack{
                            CheckBox(isChecked: $isPrivacyLicenseAccepted, title: "개인정보 수집 및 처리 방침")
                            
                            Spacer()
                            
                            Button(action: {}){
                                Text("읽기")
                            }
                        }
                    }
                    
                    Spacer().frame(height: 20)
                    
                    if showProgress{
                        DotProgressView()
                    } else{
                        Button(action: {
                            if !getEmptyFields(){
                                showProgress = true
                                
                                if password.count < 6{
                                    showProgress = false
                                    alertType = .WEAK_PASSWORD
                                    showAlert = true
                                } else if password != checkPassword{
                                    showProgress = false
                                    alertType = .PASSWORD_MISMATCH
                                    showAlert = true
                                } else if !email.contains("@"){
                                    showProgress = false
                                    alertType = .INCORRECT_EMAIL_TYPE
                                    showAlert = true
                                }else{
                                    helper.signUp(email: email, password: password, name: name, phone: phone, nickName: nickName){ result in
                                        guard let result = result else{return}
                                        
                                        showProgress = false
                                        
                                        if result == .SUCCESS{
                                            authInfo = "\(AES256Util.encrypt(string: email)), \(AES256Util.encrypt(string: password))"
                                            
                                            changeView = true
                                        } else{
                                            alertType = result
                                            showAlert = true
                                        }
                                    }
                                }
                            }
                        }){
                            HStack{
                                Spacer()
                                
                                Text("회원가입")
                                    .foregroundStyle(Color.txt)
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color.txt)
                                
                                Spacer()
                            }
                        }.buttonStyle(NewMorphButtonStyle(foreground: Color.background))
                    }
                }.padding(20)
                    .fullScreenCover(isPresented: $changeView, content: {
                        MainView()
                            .environmentObject(helper)
                    })
                    .navigationTitle(Text("회원가입"))
                    .alert(isPresented: $showAlert, error: alertType){ _ in
                        
                    } message: { error in
                        Text(error.recoverySuggestion ?? "")
                    }
                    .animation(.easeInOut)
            }
        }
    }
}

#Preview {
    SignUpView()
}
