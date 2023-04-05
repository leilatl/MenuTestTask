//
//  MenuInteractor.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//

import Foundation
protocol IMenuInteractor {
	func showMenuItems(for category: String)
	func showCategories(selectedId: Int)
}

class MenuInteractor: IMenuInteractor {
	private var worker: IMenuWorker
	private var presenter: IMenuPresenter

	init(worker: IMenuWorker, presenter: IMenuPresenter) {
		self.worker = worker
		self.presenter = presenter
	}

	/// метод, инициирующий запрос в сеть списка категорий . selectedId - текущая выбранная категория
	func showCategories(selectedId: Int) {
		var categories = [MenuModel.BusinessLogic.Category]()

		worker.getCategories { categoryData in
			for category in categoryData.categories {
				let newCategory = MenuModel.BusinessLogic.Category(title: category.strCategory)
				categories.append(newCategory)
			}

			self.presenter.presentCategories(response: categories, selectedId: selectedId)

		}

	}

	/// метод, инициирующий запрос в сеть списка блюд в категории for category - текст названия категории
	func showMenuItems(for category: String) {
		var menuItems = [MenuModel.BusinessLogic.MenuItem]()

		worker.getMenuItemsForCategory(category: category, completion: { mealData in
			for meal in mealData.meals {

				self.worker.getMenuItemIngredients(id: meal.idMeal, completion: { mealDetail in
					var compositionStr = ""
					if mealDetail.meals.isEmpty {

					} else {
						compositionStr = """
										\(mealDetail.meals[0].strIngredient1), \(mealDetail.meals[0].strIngredient2), \
										\(mealDetail.meals[0].strIngredient3), \(mealDetail.meals[0].strIngredient4), \
										\(mealDetail.meals[0].strIngredient5)
										"""
					}

					let newMenuItem = MenuModel.BusinessLogic.MenuItem(
						title: meal.strMeal, composition: compositionStr, image: meal.strMealThumb, price: 300)

					menuItems.append(newMenuItem)
					self.presenter.presentMeals(meals: menuItems)
				})
			}
		})
	}
}
