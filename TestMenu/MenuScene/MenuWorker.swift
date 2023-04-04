//
//  MenuWorker.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//

import Foundation
import Alamofire

protocol IMenuWorker {
	func getCategories(completion: @escaping (MenuModel.NetworkingData.CategoryData) -> Void)
	func getMenuItemsForCategory(category: String, completion: @escaping (MenuModel.NetworkingData.MealData) -> Void)
	func getMenuItemIngredients(id: String, completion: @escaping (MenuModel.NetworkingData.MealDetailData) -> Void)
}

class MenuWorker: IMenuWorker {
	
	func getCategories(completion: @escaping (MenuModel.NetworkingData.CategoryData) -> Void) {
		AF.request("https://themealdb.com/api/json/v1/1/categories.php").responseDecodable(of: MenuModel.NetworkingData.CategoryData.self) { response in
			if let dataCategory = response.value {
				completion(dataCategory)
			} else {
				completion(MenuModel.NetworkingData.CategoryData(categories: []))
			}
		}
	}
	
	
	func getMenuItemsForCategory(category: String, completion: @escaping (MenuModel.NetworkingData.MealData) -> Void) {
		
		AF.request("https://themealdb.com/api/json/v1/1/filter.php?c=\(category)").responseDecodable(of: MenuModel.NetworkingData.MealData.self) { response in
			
			if let dataMenu = response.value {
				completion(dataMenu)
			} else {
				completion(MenuModel.NetworkingData.MealData(meals: []))
			}
			
		}
	}
	
	func getMenuItemIngredients(id: String, completion: @escaping (MenuModel.NetworkingData.MealDetailData) -> Void) {
		AF.request("https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)").responseDecodable(of: MenuModel.NetworkingData.MealDetailData.self) { response in
			
			if let dataMeal = response.value {
				completion(dataMeal)
			} else {
				completion(MenuModel.NetworkingData.MealDetailData(meals: []))
			}
			
		}
	}
}
