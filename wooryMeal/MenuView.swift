//
//  MenuView.swift
//  wooryMeal
//
//  Created by Hyun on 1/4/25.
//

import SwiftUI

struct MenuView: View {
    let mealData:Meal?
    let type:String
    var body: some View {
        GroupBox(label: Text(type)
            .padding(.vertical,2.5)
            .padding(.horizontal, 7)
            .overlay(content: { RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray)
            })
        ){
            if let meal = mealData{
                ScrollView(content: {
                    VStack(alignment: .leading){
                        Text(meal.rice.joined(separator: ", "))
                        Text(meal.soup)
                        ForEach(meal.dishes, id: \.self){ dish in
                            Text(dish)
                        }
                        Text(meal.kimchi)
                        ForEach(meal.plusCorner, id: \.self){ dish in
                            Text(dish)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                })
            }else{
                VStack(alignment: .center){
                    Spacer()
                    Text("미운영")
                    Spacer()
                }
            }
        }
        .overlay(content: { RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray)
        })
        .frame(height: 250, alignment: .topLeading)
        .padding(.bottom, 10)
    }
}

#Preview {
    let meal = Meal(rice: ["쌀밥","현미밥"], soup: "곤약어묵탕", dishes: ["국물떡볶이", "모둠튀김", "봄동겉절이"], kimchi: "깍두기", plusCorner: ["그린샐러드","매실주스"])
    MenuView(mealData: meal, type: "점심")
}
