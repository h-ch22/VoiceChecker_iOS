//
//  MainView.swift
//  VoiceChecker
//
//  Created by 하창진 on 3/3/24.
//

import SwiftUI

struct MainView: View {
    @State var selectedIndex = 0
    @State private var showModal = false
    
    @EnvironmentObject var userManagement: UserManagement
    
    private let icons = ["house.fill", "chart.bar.xaxis", "plus", "calendar.badge.clock", "ellipsis.circle.fill"]
    private let titles = ["홈", "차트", "측정", "기록", "더 보기"]
    
    var body: some View {
        NavigationStack{
            VStack{
                ZStack{
                    switch selectedIndex{
                    case 0:
                        HomeView()
                            .environmentObject(userManagement)
                        
                    case 1:
                        ChartView()
                        
                    case 3:
                        HistoryView()
                        
                    case 4:
                        MoreView()
                        
                    default:
                        HomeView()
                            .environmentObject(userManagement)
                    }
                }
                
                Spacer()
                
                HStack{
                    ForEach(0..<5, id:\.self){number in
                        Spacer()
                        
                        Button(action: {
                            if number == 2{
                                self.showModal = true
                            }
                            
                            else{
                                selectedIndex = number
                            }
                        }){
                            if number == 2{
                                Image(systemName: icons[number])
                                    .font(.system(
                                        size: 25,
                                        weight: .regular,
                                        design: .default
                                    ))
                                    .foregroundStyle(Color.txt)
                                    .frame(width : 60, height : 60)
                                    .background(
                                        Circle()
                                            .fill(Color.background)
                                            .shadow(color: Color.shadowStart.opacity(0.2), radius: 10, x: 10, y: 10)
                                            .shadow(color: Color.shadowEnd.opacity(0.7), radius: 10, x: -5, y: -5)
                                    )
                            }
                            
                            else{
                                if UIDevice.current.userInterfaceIdiom == .pad{
                                    HStack{
                                        Image(systemName: icons[number])
                                            .font(.system(
                                                size: 20,
                                                weight: .regular,
                                                design: .default
                                            ))
                                            .foregroundStyle(selectedIndex == number ? Color.txt : Color.gray)
                                        
                                        Spacer().frame(width: 5)
                                        
                                        if selectedIndex == number{
                                            Text(titles[number])
                                                .font(.caption)
                                                .foregroundStyle(Color.txt)
                                        }
                                    }.padding(selectedIndex == number ? 10 : 0)
                                        .background(RoundedRectangle(cornerRadius: selectedIndex == number ? 15 : 0).foregroundStyle(selectedIndex == number ? Color.background : Color.clear).opacity(0.6))
                                } else{
                                    VStack{
                                        Image(systemName: icons[number])
                                            .font(.system(
                                                size: 20,
                                                weight: .regular,
                                                design: .default
                                            ))
                                            .foregroundStyle(selectedIndex == number ? Color.txt : Color.gray)
                                        
                                        Spacer().frame(height: 5)
                                        
                                        if selectedIndex == number{
                                            Text(titles[number])
                                                .font(.caption)
                                                .foregroundStyle(Color.txt)
                                        }
                                    }.padding(selectedIndex == number ? 10 : 0)
                                        .background(RoundedRectangle(cornerRadius: selectedIndex == number ? 15 : 0).foregroundStyle(selectedIndex == number ? Color.background : Color.clear).opacity(0.6))
                                }
                            }
                            
                        }
                        
                        Spacer()
                    }
                }.padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding([.horizontal], 5)
                    .animation(.easeInOut)
            }
            
            .sheet(isPresented: $showModal, content: {
                InspectionView()
                    .environmentObject(userManagement)
            })
            .background(Color.background.ignoresSafeArea(.all, edges: [.top, .bottom]))
            
        }
        .toolbar(.hidden)
        
    }
}

#Preview {
    MainView()
        .environmentObject(UserManagement())
}

#Preview {
    MainView()
}
