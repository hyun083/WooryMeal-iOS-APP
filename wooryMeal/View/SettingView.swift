//
//  SettingView.swift
//  wooryMeal
//
//  Created by Hyun on 5/30/25.
//

import SwiftUI


struct SettingView: View {
    @Binding var selectedRegion: RegionType
    @Binding var preferredMenu: [String]
    
    @State private var newKeyword: String = ""
    @State private var showAddAlert: Bool = false
    
    var body: some View {
        List{
            Section{
                Picker("조회 지역", selection: $selectedRegion){
                    Text("용인 연구소").tag(RegionType.yongin)
                    Text("평택 공장").tag(RegionType.pyeongtaek)
                }
            } /*header: { Text("section1") }*/
            
            Section{
                DisclosureGroup("선호 음식"){
                    ForEach(preferredMenu, id: \.self) { keyword in
                        HStack {
                            Text(keyword)
                            Spacer()
                            Button(role: .destructive) {
                                if let index = preferredMenu.firstIndex(of: keyword) {
                                    preferredMenu.remove(at: index)
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
                
                Button(){
                    showAddAlert = true
                }label: {
                    Label("추가", systemImage: "plus")
                }
                .alert("선호 음식 추가", isPresented: $showAddAlert, actions: {
                    TextField("음식 이름", text: $newKeyword)
                    Button("추가") {
                        let trimmed = newKeyword.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ").map{String($0)}
                        
                        for item in trimmed {
                            if !preferredMenu.contains(item){
                                preferredMenu.append(item)
                            }
                        }
                        newKeyword = ""
                    }
                    Button("취소", role: .cancel) {
                        newKeyword = ""
                    }
                })
            } /*header: { Text("section2") }*/
        }
    }
}

#Preview {
    @ObservedObject var vm = MenuViewModel()
    SettingView(selectedRegion: $vm.region, preferredMenu: $vm.preferredMenu)
}
