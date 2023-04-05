//
//  MenuTableViewCell.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//
// swiftlint: disable trailing_whitespace line_length
import UIKit
import SDWebImage

/// класс ячейки в списке блюд. описывает интерфейс каждой ячейки в списке блюд.
class MenuCell: UITableViewCell {
	
	/// картинка блюда
	let itemImageView = UIImageView()
	/// текст названия блюда
	let itemTitlelabel = BasicLabel(text: "", size: MenuDigits.mealLabelTextSize, weight: .semibold)
	/// текст описания блюда
	let decriptionLabel = BasicLabel(text: "", color: MenuColors.greyText!, size: MenuDigits.mealPriceTextSize)
	/// текст цены блюда
	let priceLabel = BasicLabel(text: "", color: MenuColors.pink!, size: MenuDigits.mealPriceTextSize, weight: .light)
	/// контейнер цены блюда
	let priceView = UIView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.style()
		layout()
	}
	
	private func style() {
		priceView.layer.borderWidth = MenuDigits.categoryCellborderWidth
		priceView.backgroundColor = .white
		priceView.layer.borderColor = MenuColors.pink?.cgColor
		priceView.layer.cornerRadius = MenuDigits.priceViewRadius
		
		itemTitlelabel.textAlignment = .left
		
		decriptionLabel.textAlignment = .left
	}
	
	private func layout() {
		priceLabel.translatesAutoresizingMaskIntoConstraints = false
		
		priceView.addSubview(priceLabel)
		addSubviews(views: [itemImageView, itemTitlelabel, decriptionLabel, priceView])
		
		NSLayoutConstraint.activate([
			itemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: MenuDigits.leadingTrailingConstants),
			itemImageView.heightAnchor.constraint(equalToConstant: MenuDigits.mealImageHeight),
			itemImageView.widthAnchor.constraint(equalToConstant: MenuDigits.mealImageHeight),
			
			itemTitlelabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: MenuDigits.mealSpacing),
			itemTitlelabel.topAnchor.constraint(equalTo: itemImageView.topAnchor),
			itemTitlelabel.widthAnchor.constraint(equalToConstant: MenuDigits.mealDescriptionWidth),
			
			decriptionLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: MenuDigits.mealSpacing),
			decriptionLabel.topAnchor.constraint(equalTo: itemTitlelabel.bottomAnchor, constant: MenuDigits.leadingTrailingConstants),
			decriptionLabel.widthAnchor.constraint(equalToConstant: MenuDigits.mealDescriptionWidth),
			
			priceView.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor),
			priceView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -MenuDigits.leadingTrailingConstants),
			priceView.heightAnchor.constraint(equalToConstant: MenuDigits.mealPriceHeight),
			priceView.widthAnchor.constraint(equalToConstant: MenuDigits.mealPriceWidth),
			
			priceLabel.centerYAnchor.constraint(equalTo: priceView.centerYAnchor),
			priceLabel.centerXAnchor.constraint(equalTo: priceView.centerXAnchor)
		])
	}
	
	func update(viewModel: MenuModel.ViewModel, index: Int) {
		itemTitlelabel.text = viewModel.menuItems[index].title
		decriptionLabel.text = viewModel.menuItems[index].composition
		priceLabel.text = viewModel.menuItems[index].price
		
		let imageString = viewModel.menuItems[index].imageString
		itemImageView.sd_setImage(with: URL(string: imageString))
		
	}
	
	private func addSubviews(views: [UIView]) {
		for view in views {
			view.translatesAutoresizingMaskIntoConstraints = false
			contentView.addSubview(view)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError(MenuStrings.initFatalError)
	}
}
