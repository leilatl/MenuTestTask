//
//  PromoCollectionViewCell.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//
// swiftlint: disable trailing_whitespace

import UIKit

/// класс ячейки в коллекции промо. описывает интерфейс каждой ячейки в коллекции промо.
class PromoCollectionCell: UICollectionViewCell {
	
	/// изображение в ячейке промо
	let promoImage = UIImageView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		layout()
	}
	
	private func layout() {
		promoImage.translatesAutoresizingMaskIntoConstraints = false
		
		contentView.addSubview(promoImage)
		
		NSLayoutConstraint.activate([
			promoImage.widthAnchor.constraint(equalToConstant: MenuDigits.promoImageWidth),
			promoImage.heightAnchor.constraint(equalToConstant: MenuDigits.promoViewHeight),
			promoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			promoImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
			
		])
	}
	
	func update(imageName: String) {
		promoImage.image = UIImage(named: imageName)
	}
	
	required init?(coder: NSCoder) {
		fatalError(MenuStrings.initFatalError)
	}
}
