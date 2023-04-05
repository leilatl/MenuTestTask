//
//  MenuInteractor.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//

// swiftlint: disable line_length
import Foundation
protocol IMenuInteractor {
	func showMenuItems(for category: String)
	func showCategories(selectedId: Int)
}

class MenuInteractor: IMenuInteractor {
	private var worker: IMenuWorker
	private var presenter: IMenuPresenter
	private var coreDataManager: ICoredataManager

	init(worker: IMenuWorker, presenter: IMenuPresenter, coreDataManager: ICoredataManager) {
		self.worker = worker
		self.presenter = presenter
		self.coreDataManager = coreDataManager
	}

	/// метод, инициирующий запрос в сеть списка категорий . selectedId - текущая выбранная категория
	func showCategories(selectedId: Int) {
		worker.getCategories { categoryData in

			// если из сервера мы получили пустой список, то обращаемся к coredata
			if categoryData.categories.isEmpty {
				// получаем все в coredata
				let coreDataCategories = self.coreDataManager.getAllCategories()
				// преобразуем в модель бизнес логики
				let newData = self.categoriesCoredDataToBusinessLogic(coreDataObjects: coreDataCategories)
				// передаем презентеру
				self.presenter.presentCategories(response: newData, selectedId: selectedId)
			} else { // если из сервера пришел не пустой список
				// очищаем coredata, чтобы сохранить новый список
				self.coreDataManager.deleteAllCategories()

				// создаем пустой список категорий, чтобы наполнить его и передать презентеру
				var categories = [MenuModel.BusinessLogic.Category]()

				// для каждого объекта в спике
				for category in categoryData.categories {
					// преобразуем в модель бизнес логики
					let newCategory = MenuModel.BusinessLogic.Category(title: category.strCategory)
					// записываем в coredata
					self.coreDataManager.createCategory(title: category.strCategory, isSelected: false)
					categories.append(newCategory)
				}
				// передаем презентеру новый писок
				self.presenter.presentCategories(response: categories, selectedId: selectedId)
			}
		}

	}

	/// метод, инициирующий запрос в сеть списка блюд в категории for category - текст названия категории
	func showMenuItems(for category: String) {

		worker.getMenuItemsForCategory(category: category, completion: { mealData in

			if mealData.meals.isEmpty { // если список пустой, то обращаемся к coredata
				// достаем все из coredata
				let coreDataMeals = self.coreDataManager.getAllMenuItems()
				// преобразуем в модель бизнес логики
				let newData = self.mealsCoreDataToBusinessLogic(coreDataObjects: coreDataMeals)
				// передаем презентеру
				self.presenter.presentMeals(meals: newData)
			} else { // если из сервера пришел непустой список
				// очищаем coredata, чтобы сохранить новый список
				self.coreDataManager.deleteAllMenuItems()

				// создаем пустой список категорий, чтобы наполнить его и передать презентеру
				var menuItems = [MenuModel.BusinessLogic.MenuItem]()

				// для каждого объекта в списке которой получили от сервера
				for meal in mealData.meals {

					// дополнительный запрос для получения состава
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

						// преобразуем в модель бизнес логики
						let newMenuItem = MenuModel.BusinessLogic.MenuItem(
							title: meal.strMeal, composition: compositionStr, image: meal.strMealThumb, price: 300)
						self.coreDataManager.createMenuItem(title: newMenuItem.title, price: "300", composition: newMenuItem.composition)

						menuItems.append(newMenuItem)
						self.presenter.presentMeals(meals: menuItems)
					})
				}
			}
		})
	}
}

extension MenuInteractor {
	private func categoriesCoredDataToBusinessLogic(coreDataObjects: [CategoryCoreData]) -> [MenuModel.BusinessLogic.Category] {
		var newCategories = [MenuModel.BusinessLogic.Category]()
		for category in coreDataObjects {
			let newCategory = MenuModel.BusinessLogic.Category(title: category.title ?? "")
			newCategories.append(newCategory)
		}

		return newCategories
	}

	private func mealsCoreDataToBusinessLogic(coreDataObjects: [MenuItemCoreData]) -> [MenuModel.BusinessLogic.MenuItem] {
		var newMeals = [MenuModel.BusinessLogic.MenuItem]()
		for meal in coreDataObjects {
			let newMeal = MenuModel.BusinessLogic.MenuItem(title: meal.title ?? "",
														   composition: meal.composition ?? "",
														   image: "",
														   price: 300)
			newMeals.append(newMeal)
		}
		return newMeals
	}
}
