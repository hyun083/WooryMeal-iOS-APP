//
//  WeeklyView.swift
//  wooryMeal
//
//  Created by Hyun on 1/4/25.
//

import SwiftUI

struct WeeklyView: View {
    //static let menus: [Table] = [Table(id: 1, date: "2025-01-21", meals: Meals(lunch: Meal(), dinner: Meal()))]
    let menus: [Table]

    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                ForEach(menus, id: \.id){ item in
                    VStack(alignment:.leading){
                        let date = item.date.split(separator: "-")
                        let month = date[1]
                        let day = date[2]
                        GroupBox(label: Text("\(month)월 \(day)일")){
                            if let lunch = item.meals.lunch{
                                HStack{
                                    VStack(alignment: .leading){
                                        Text("점심")
                                            .padding(.vertical,2.5)
                                            .padding(.horizontal, 7)
                                            .overlay(content: { RoundedRectangle(cornerRadius: 5)
                                                    .stroke(Color.gray)
                                            })
                                        mealListView(meal: lunch)
                                    }
                                    Spacer()
                                }
                            }
                            if let dinner = item.meals.dinner{
                                HStack{
                                    VStack(alignment: .leading){
                                        Text("저녁")
                                            .padding(.vertical,2.5)
                                            .padding(.horizontal, 7)
                                            .overlay(content: { RoundedRectangle(cornerRadius: 5)
                                                    .stroke(Color.gray)
                                            })
                                        mealListView(meal: dinner)
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .overlay(content: { RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray)
                        })
                        .padding(.horizontal)
                    }
                }
            }
            //.background(Color.red)
            .padding(.vertical, 1)
        }
    }
}

struct mealListView: View{
    let meal: Meal
    let data: [String]
    
    init(meal: Meal) {
        self.meal = meal
        self.data = meal.rice
        + [meal.soup]
        + meal.dishes
        + [meal.kimchi]
        + meal.plusCorner
    }
    
    var body: some View{
        Text(data.joined(separator: ", "))
    }
}

#Preview {
    let menus: [Table] = [Table(id: 1, date: "2025-01-21", meals: Meals(lunch: Meal(), dinner: Meal()), order: ["1조","2조","3조"])]
    WeeklyView(menus: menus)
}
