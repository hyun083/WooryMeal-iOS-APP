//
//  ContentView.swift
//  wooryMeal
//
//  Created by Hyun on 12/16/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject private var menuVM = MenuViewModel()
    
    var body: some View {
        TabView(){
            NavigationView(){
                VStack{
                    HStack{
                        Image("woory_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                        Spacer()
                        Text(menuVM.todayMenu?.order.joined(separator: " → ") ?? " ")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 3)
                    HStack{
                        if menuVM.region == RegionType.pyeongtaek{
                            MenuView(mealData: menuVM.todayMenu?.meals.breakfast, type: "오늘 아침", preferredMenu: menuVM.preferredMenu)
                        }
                        MenuView(mealData: menuVM.todayMenu?.meals.lunch, type: "오늘 점심", preferredMenu: menuVM.preferredMenu)
                        MenuView(mealData: menuVM.todayMenu?.meals.dinner, type: "오늘 저녁", preferredMenu: menuVM.preferredMenu)
                    }
                    .padding(.horizontal,15)
                    Spacer()
                    WeeklyView(menus: menuVM.menus, preferredMenu: menuVM.preferredMenu)
                }
                .navigationBarTitleDisplayMode(.large)
            }
            .tabItem{ Label("식단표", systemImage: "list.bullet") }
            
            SettingView(selectedRegion: $menuVM.region, preferredMenu: $menuVM.preferredMenu)
                .tabItem{ Label("설정", systemImage: "gear") }
        }
        .onAppear(){
            menuVM.fetchMenus()
            print(scenePhase, "<- onAppear")
        }
        .onChange(of: scenePhase) {
            print(scenePhase)
            if scenePhase == .inactive {
                menuVM.fetchMenus()
            }
        }
    }
}

#Preview {
    ContentView()
}
