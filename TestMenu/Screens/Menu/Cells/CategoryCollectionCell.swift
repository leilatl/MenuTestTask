//
//  CategoryCollectionViewCell.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//

import UIKit

/// класс ячейки в коллекции категорий. описывает интерфейс каждой ячейки в коллекции категорий.
class CategoryCollectionCell: UICollectionViewCell {

	/// текст названия категории
	let label = UILabel()
	/// контейнер текста названия категории
	let labelView = UIView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		style()
		layout()
	}

	private func style() {

		labelView.backgroundColor = MenuColors.greyBackground
		labelView.layer.cornerRadius = MenuDigits.categoryCellRadius
		labelView.layer.borderWidth = MenuDigits.categoryCellborderWidth
		labelView.layer.borderColor = MenuColors.lightPink?.cgColor

		label.font = UIFont.systemFont(ofSize: MenuDigits.categoriesLabelTextSize)
		label.textColor = MenuColors.lightPink
	}

	private func layout() {
		labelView.translatesAutoresizingMaskIntoConstraints = false
		label.translatesAutoresizingMaskIntoConstraints = false

		contentView.addSubview(labelView)
		labelView.addSubview(label)

		NSLayoutConstraint.activate([
			labelView.topAnchor.constraint(equalTo: contentView.topAnchor),
			labelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			labelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			labelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

			label.centerXAnchor.constraint(equalTo: labelView.centerXAnchor),
			label.centerYAnchor.constraint(equalTo: labelView.centerYAnchor)
		])
	}

	func update(title: String, selected: MenuModel.ViewModel.CellStatus) {
		label.text = title
		if selected == .selected {
			labelView.backgroundColor = MenuColors.palePink
			labelView.layer.borderColor = MenuColors.palePink?.cgColor
			label.font = UIFont.systemFont(ofSize: MenuDigits.categoriesLabelTextSize, weight: .semibold)
			label.textColor = MenuColors.pink
		} else {
			labelView.backgroundColor = MenuColors.greyBackground
			labelView.layer.borderColor = MenuColors.lightPink?.cgColor
			label.font = UIFont.systemFont(ofSize: MenuDigits.categoriesLabelTextSize, weight: .light)
			label.textColor = MenuColors.lightPink
		}
	}

	required init?(coder: NSCoder) {
		fatalError(MenuStrings.initFatalError)
	}
}
