//
//  MenuPresenter.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//
// swiftlint: disable trailing_whitespace vertical_parameter_alignment
import Foundation
import UIKit
import SDWebImage
protocol IMenuPresenter {
	func presentCategories(response: [MenuModel.BusinessLogic.Category], selectedId: Int)
	func presentMeals(meals: [MenuModel.BusinessLogic.MenuItem])
}

class MenuPresenter: IMenuPresenter {
	weak var viewController: MenuViewController?
	
	func setViewController(viewController: MenuViewController) {
		self.viewController = viewController
	}

	/// метод, преобразующий вьюмодель и передающий его в вью контроллер для отображения списка категорий
	func presentCategories(response: [MenuModel.BusinessLogic.Category], selectedId: Int) {
		let viewModel = getViewDataCategoryFromResponse(response: response, selectedId: selectedId)
		viewController?.renderCategory(viewModel: viewModel)
	}

	/// метод, преобразующий вьюмодель и передающий его в вью контроллер для отображения списка блюд
	func presentMeals(meals: [MenuModel.BusinessLogic.MenuItem]) {
		let viewModel = getDataMealsFromResponse(response: meals)
		viewController?.renderMeals(viewModel: viewModel)
	}
	
	private func getViewDataCategoryFromResponse(response: [MenuModel.BusinessLogic.Category],
												 selectedId: Int) -> [MenuModel.ViewModel.Category] {
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
			
			let newMeal = MenuModel.ViewModel.MenuItem(title: meal.title,
													   composition: meal.composition,
													   imageString: newString,
													   price: "от \(String(meal.price)) руб.")
			meals.append(newMeal)
		}
		
		return meals
	}
}
