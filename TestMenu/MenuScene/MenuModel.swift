//
//  MenuModel.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//
// swiftlint: disable nesting
import Foundation
import UIKit
/// перечисление моделей для работы с экраном меню
enum MenuModel {

	/// структура для работы с сетевыми запросами
	struct NetworkingData {

		/// структура, описываеющая структуру json моделей блюд в категории
		struct MealData: Decodable {
			let meals: [Meal]

			struct Meal: Decodable {
				let strMeal: String
				let strMealThumb: String
				let idMeal: String
			}
		}

		/// структура, описываеющая структуру json моделей категорий
		struct CategoryData: Decodable {
			let categories: [NetworkingCategory]

			struct NetworkingCategory: Decodable {
				let idCategory: String
				let strCategory: String
				let strCategoryThumb: String
				let strCategoryDescription: String
			}
		}

		/// структура, описываеющая структуру json моделей деталей блюд
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

	/// структура для работы с уровнем Presenter. передает все необходимое для последующего преобразования в вью модель.
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

	/// структура для работы с уровнем View. передает все необходимое для отображения в интерфейсе
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
