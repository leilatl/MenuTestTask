//
//  CategoryCollectionViewCell.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//

import UIKit

/// класс ячейки в коллекции категорий. описывает интерфейс каждой ячейки в коллекции категорий.
class CategoryCollectionViewCell: UICollectionViewCell {

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
		labelView.translatesAutoresizingMaskIntoConstraints = false
		label.translatesAutoresizingMaskIntoConstraints = false

		labelView.backgroundColor = UIColor(named: "Background Grey")
		labelView.layer.cornerRadius = 20
		labelView.layer.borderWidth = 1
		labelView.layer.borderColor = UIColor(named: "Light Pink")?.cgColor

		label.font = UIFont.systemFont(ofSize: 16)
		label.textColor = UIColor(named: "Light Pink")
	}

	private func layout() {
		contentView.addSubview(labelView)
		labelView.addSubview(label)

		NSLayoutConstraint.activate([
			labelView.topAnchor.constraint(equalTo: contentView.topAnchor),
			labelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
			labelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			labelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

			label.centerXAnchor.constraint(equalTo: labelView.centerXAnchor),
			label.centerYAnchor.constraint(equalTo: labelView.centerYAnchor)
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
