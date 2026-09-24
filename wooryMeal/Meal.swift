//
//  Meal.swift
//  wooryMeal
//
//  Created by Hyun on 12/16/24.
//

import Foundation

// MARK: - Table
struct Table: Codable, Identifiable{
    let id:Int
    let date: String
    let meals: Meals
    let order: [String]
}

// MARK: - Meals
struct Meals: Codable{
    let breakfast, lunch, dinner: Meal?
}

// MARK: - Meal
struct Meal: Codable {
    let rice: [String]
    let soup: String
    let dishes: [String]
    let kimchi: String
    let plusCorner: [String]

    enum CodingKeys: String, CodingKey {
        case rice, soup, dishes, kimchi, plusCorner
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rice = try container.decode([String].self, forKey: .rice)
        soup = try container.decode(String.self, forKey: .soup)
        dishes = try container.decode([String].self, forKey: .dishes)
        kimchi = try container.decode(String.self, forKey: .kimchi)
        plusCorner = try container.decode([String].self, forKey: .plusCorner)
    }
    
    init(rice:[String], soup:String, dishes:[String], kimchi:String, plusCorner:[String]){
        self.rice = rice
        self.soup = soup
        self.dishes = dishes
        self.kimchi = kimchi
        self.plusCorner = plusCorner
    }
    
    init(){
        self.rice = ["정보없음","정보없음"]
        self.soup = "정보없음"
        self.dishes = ["정보없음","정보없음","정보없음"]
        self.kimchi = "정보없음"
        self.plusCorner = ["정보없음"]
    }
}
