//
//  BasicLabel.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//

import UIKit

/// кастомный лейбл. класс, который упрощает создание нового лейбла в интерфейсе
class BasicLabel: UILabel {

	init(text: String, color: UIColor = .black, size: CGFloat = 16, weight: UIFont.Weight = .medium) {
		super.init(frame: .zero)
		self.text = text
		textColor = color
		textAlignment = .center
		backgroundColor = .clear
		font = UIFont.systemFont(ofSize: size, weight: weight)
		numberOfLines = 0
	}

	required init?(coder: NSCoder) {
		fatalError(MenuStrings.coreDataError)
	}
}
