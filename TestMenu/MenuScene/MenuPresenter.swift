//
//  MenuPresenter.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//

import Foundation
import UIKit
import SDWebImage
protocol IMenuPresenter {
	func presentCategories(response: [MenuModel.BusinessLogic.Category], selectedId: Int)
	func presentMeals(meals: [MenuModel.BusinessLogic.MenuItem], id: Int)
}

class MenuPresenter: IMenuPresenter {
	private weak var viewController: MenuViewController?
	
	init(viewController: MenuViewController?) {
		self.viewController = viewController
	}
	
	func presentCategories(response: [MenuModel.BusinessLogic.Category], selectedId: Int) {
		let viewModel = getViewDataCategoryFromResponse(response: response, selectedId: selectedId)
		viewController?.renderCategory(viewModel: viewModel)
	}
	
	func presentMeals(meals: [MenuModel.BusinessLogic.MenuItem], id: Int) {
		let viewModel = getDataMealsFromResponse(response: meals)
		viewController?.renderMeals(viewModel: viewModel, id: id)
	}
	
	private func getViewDataCategoryFromResponse(response: [MenuModel.BusinessLogic.Category], selectedId: Int) -> [MenuModel.ViewModel.Category] {
		var categories = [MenuModel.ViewModel.Category]()
		
		for categoryResponse in response {
			let newCategory = MenuModel.ViewModel.Category(title: categoryResponse.title, status: .normal)
			categories.append(newCategory)
		}
		categories[selectedId].status = .selected
		
		return categories
	}
	
	private func getDataMealsFromResponse(response: [MenuModel.BusinessLogic.MenuItem]) -> [MenuModel.ViewModel.MenuItem] {
		var meals = [MenuModel.ViewModel.MenuItem]()
		
		for meal in response {
			
			let dataString = NSString(string: meal.image)
			let newString = dataString.replacingOccurrences(of: #"\/"#, with: "//")
										.replacingOccurrences(of: "////", with: "//")
			
			let newMeal = MenuModel.ViewModel.MenuItem(title: meal.title, composition: meal.composition, imageString: newString, price: "от \(String(meal.price)) руб.")
			meals.append(newMeal)
		}
		
		return meals
	}
}
