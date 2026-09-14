//
//  MenuViewModel.swift
//  wooryMeal
//
//  Created by Hyun on 12/23/24.
//

import Foundation

enum RegionType:String{
    case yongin, pyeongtaek
}

class MenuViewModel: ObservableObject {
    @Published var menus: [Table] = []
    @Published var errorMessage: String?
    @Published var todayMenu: Table?
    @Published var region: RegionType{
        didSet{ setSelectedRegion() }
    }
    @Published var preferredMenu: [String]{
        didSet{ setPreferredMenu() }
    }
    let dateFormatter: DateFormatter

    init(){
        self.region = {
            if let regionTypeString = UserDefaults.standard.string(forKey: "region"){
                return RegionType(rawValue: regionTypeString) ?? .yongin
            }else{
                return .yongin
            }
        }()
        
        self.preferredMenu = UserDefaults.standard.object(forKey: "userPreferred") as? [String] ?? [String]()
        
        self.dateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
    }
    
    func fetchMenus() {
        TableManager.shared.fetchMenuData(for: region) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let menus):
                    let now = Date()
                    
                    self.todayMenu = nil
                    self.menus = []
                    for menu in menus{
                        #if false
                        let testDate = "2025-06-16"
                        if menu.date == testDate{
                            self.todayMenu = menu
                        }else if menu.date > testDate{
                            self.menus.append(menu)
                        }
                        #else
                        if menu.date == self.dateFormatter.string(from: now){
                            self.todayMenu = menu
                            print(menu.date,"today")
                        }else if menu.date > self.dateFormatter.string(from: now){
                            self.menus.append(menu)
                            if let date = self.dateFormatter.date(from: menu.date){
                                let weekday = Calendar.current.component(.weekday, from: date)
                                print(menu.date,weekday,"요일 ")
                            }
                        }
                        #endif
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchMenus(on date: String) {
        TableManager.shared.fetchMenuData(for: region, on: date) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let menus):
                    self.menus = menus
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func setSelectedRegion(){
        UserDefaults.standard.set(self.region.rawValue, forKey: "region")
        fetchMenus()
        print("region: \(self.region.rawValue) set.")
    }
    
    func setPreferredMenu(){
        UserDefaults.standard.set(self.preferredMenu, forKey: "userPreferred")
        fetchMenus()
        print("userPreferred updated",self.preferredMenu)
    }
}
