//
//  MenuModel.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//

import Foundation
import UIKit
enum MenuModel {
	
	struct NetworkingData {
		
		struct MealData: Decodable {
			let meals: [Meal]
			
			struct Meal: Decodable {
				let strMeal: String
				let strMealThumb: String
				let idMeal: String
			}
		}
		
		struct CategoryData: Decodable {
			let categories: [NetworkingCategory]
			
			struct NetworkingCategory: Decodable {
				let idCategory: String
				let strCategory: String
				let strCategoryThumb: String
				let strCategoryDescription: String
			}
		}
		
		struct MealDetailData: Decodable {
			let meals: [MealDetail]
			
			struct MealDetail: Decodable {
				let strIngredient1: String
				let strIngredient2: String
				let strIngredient3: String
				let strIngredient4: String
				let strIngredient5: String
			}
			
		}
	}
	
	struct BusinessLogic {
		
		struct Category {
			let title: String
		}
		
		struct MenuItem {
			let title: String
			let composition: String
			let image: String
			let price: Int
		}
	}
	
	struct ViewModel {
		var categories: [Category]
		var menuItems: [MenuItem]
		
		struct Category {
			let title: String
			var status: CellStatus
		}
		
		struct MenuItem {
			let title: String
			let composition: String
			let imageString: String
			let price: String
		}
		
		enum CellStatus {
			case selected
			case normal
		}
	}
}




