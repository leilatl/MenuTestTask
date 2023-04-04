//
//  MenuTableViewCell.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//

import UIKit
import SDWebImage
class MenuTableViewCell: UITableViewCell {
	
	let itemImageView = UIImageView()
	let itemTitlelabel = BasicLabel(text: "", size: 18.5, weight: .semibold)
	let decriptionLabel = BasicLabel(text: "", color: UIColor(named: "Grey Text")!, size: 13)
	let priceView = UIView()
	let priceLabel = BasicLabel(text: "", color: UIColor(named: "Pink")!, size: 13, weight: .light)
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.style()
		layout()
	}
	
	private func style() {
		priceLabel.translatesAutoresizingMaskIntoConstraints = false
		
		priceView.layer.borderWidth = 1
		priceView.backgroundColor = .white
		priceView.layer.borderColor = UIColor(named: "Pink")?.cgColor
		priceView.layer.cornerRadius = 10
		
		decriptionLabel.textAlignment = .left
	}
	
	private func layout() {
		priceView.addSubview(priceLabel)
		addSubviews(views: [itemImageView, itemTitlelabel, decriptionLabel, priceView])
		
		NSLayoutConstraint.activate([
			itemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			itemImageView.heightAnchor.constraint(equalToConstant: 132),
			itemImageView.widthAnchor.constraint(equalToConstant: 132),
			
			itemTitlelabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16),
			itemTitlelabel.topAnchor.constraint(equalTo: itemImageView.topAnchor),
			
			decriptionLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16),
			decriptionLabel.topAnchor.constraint(equalTo: itemTitlelabel.bottomAnchor, constant: 10),
			decriptionLabel.widthAnchor.constraint(equalToConstant: 200),
			
			priceView.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor),
			priceView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			priceView.heightAnchor.constraint(equalToConstant: 32),
			priceView.widthAnchor.constraint(equalToConstant: 86),
			
			priceLabel.centerYAnchor.constraint(equalTo: priceView.centerYAnchor),
			priceLabel.centerXAnchor.constraint(equalTo: priceView.centerXAnchor),
		])
	}
	
	private func addSubviews(views: [UIView]) {
		for view in views {
			view.translatesAutoresizingMaskIntoConstraints = false
			contentView.addSubview(view)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
