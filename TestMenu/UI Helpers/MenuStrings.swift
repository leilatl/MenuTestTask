//
//  MenuStrings.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 05.04.2023.
//
// swiftlint: disable trailing_whitespace
import Foundation
struct MenuStrings {
	static let initFatalError = "init(coder:) has not been implemented"
	static let unknownColelctionViewError = "Unknown collection view"
	static let coreDataError = "cant fetch categories from core data"

	static let firstFetchCategory = "Beef"

	static let cityLabel = "Moscow"
	
	static let categoriesCellIdentifier = "CustomCollectionViewCell"
	static let promoCellIdentifier = "PromoCollectionViewCell"
	static let tableViewCellIdentifier = "TableCell"
}

struct MenuDigits {
	static let firstSelectedId = 0
	
	static let promoImageWidth: CGFloat = 380
	static let promoImageHeight: CGFloat = 140
	static let promoViewHeight: CGFloat = 130
	static let promoCellWidth = 350
	static let promoCellHeight = 120
	
	static let tableViewCellHeight: CGFloat = 180
	
	static let headerViewHeight: CGFloat = 200
	
	static let categoriesCollectionHeight: CGFloat = 50
	static let categoriesCellWidth = 130
	static let categoriesCellHeight = 40
	static let categoryCellRadius: CGFloat = 20
	static let categoryCellborderWidth: CGFloat = 1
	
	static let mealImageHeight: CGFloat = 130
	static let mealSpacing: CGFloat = 16
	static let mealDescriptionWidth: CGFloat = 200
	static let mealPriceWidth: CGFloat = 86
	static let mealPriceHeight: CGFloat = 32
	static let priceViewRadius: CGFloat = 10
	
	static let scrollSwipeDown: CGFloat = 0
	static let scrollStickPoint: CGFloat = 30
	
	static let animationDuration = 0.3
	static let animationDelay: Double = 0
	
	static let promoViewHeightWhenSticked = 0
	
	static let leadingTrailingConstants: CGFloat = 10
	static let arrowImageLeadingConstant: CGFloat = 5
	
	static let cityLabelTextSize: CGFloat = 17
	static let categoriesLabelTextSize: CGFloat = 16
	static let mealLabelTextSize: CGFloat = 18.5
	static let mealPriceTextSize: CGFloat = 13
	
	static let numberOfPromos = 2
}
