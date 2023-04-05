//
//  CoreDataManager.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//

import Foundation
import UIKit
import CoreData

/// протокол для работы с CoreData
protocol ICoredataManager {
	func getAllCategories() -> [CategoryCoreData]
	func getAllMenuItems() -> [MenuItemCoreData]
	func createCategory(title: String, isSelected: Bool)
	func createMenuItem(title: String, price: String, composition: String)
	func deleteAllCategories()
	func deleteAllMenuItems()
}

/// менеджер CoreData
class CoreDataManager: ICoredataManager {
	private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

	/// метод для получения списка всех категорий, которые хранятся в CoreData
	func getAllCategories() -> [CategoryCoreData] {
		do {
			let categories = try context?.fetch(CategoryCoreData.fetchRequest())
			return categories ?? []
		} catch {
			print("cant fetch categories from core data")
		}

		return []
	}

	/// метод для получения списка всех блюд, которые хранятся в CoreData
	func getAllMenuItems() -> [MenuItemCoreData] {
		do {
			let menuItems = try context?.fetch(MenuItemCoreData.fetchRequest())
			return menuItems ?? []
		} catch {
			print("cant fetch menu items from core data")
		}

		return []
	}

	/// метод для создания новой категории в CoreData. title - название, isSelected - статус категории (текущая/нетекущая)
	func createCategory(title: String, isSelected: Bool) {
		let newItem = CategoryCoreData(context: context!)
		newItem.title = title
		newItem.isSelected = isSelected

		do {
			try context?.save()
		} catch {

		}
	}

	/// метод для создания нового блюда в CoreData. title - название блюда, price - цена блюда, composition - состав блюда
	func createMenuItem(title: String, price: String, composition: String) {
		let newItem = MenuItemCoreData(context: context!)
		newItem.title = title
		newItem.price = price
		newItem.composition = composition

		do {
			try context?.save()
		} catch {

		}
	}

	/// метод для удаления всех категорий в CoreData.
	func deleteAllCategories() {
		let categories = getAllCategories()
		for category in categories {
			context?.delete(category)
		}
		do {
			try context?.save()
		} catch {

		}
	}

	/// метод для удаления всех блюд в CoreData.
	func deleteAllMenuItems() {
		let menuItems = getAllMenuItems()
		for menuItem in menuItems {
			context?.delete(menuItem)
		}
		do {
			try context?.save()
		} catch {

		}
	}
}
