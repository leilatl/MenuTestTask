//
//  PromoCollectionViewCell.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//
// swiftlint: disable trailing_whitespace
import UIKit

/// класс ячейки в коллекции промо. описывает интерфейс каждой ячейки в коллекции промо.
class PromoCollectionViewCell: UICollectionViewCell {
	
	/// изображение в ячейке промо
	let promoImage = UIImageView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		style()
		layout()
	}
	
	private func style() {
		promoImage.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func layout() {
		contentView.addSubview(promoImage)
		
		NSLayoutConstraint.activate([
			promoImage.widthAnchor.constraint(equalToConstant: 380),
			promoImage.heightAnchor.constraint(equalToConstant: 140),
			promoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			promoImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
			
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
