//
//  MenuViewController.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//

import UIKit
import Alamofire

protocol IMenuViewController {
	func renderCategory(viewModel: [MenuModel.ViewModel.Category])
	func renderMeals(viewModel: [MenuModel.ViewModel.MenuItem], id: Int)
}

class MenuViewController: UIViewController {
	
	let tableView = UITableView()
	let headerView = UIView()
	var headerViewTopConstraint: NSLayoutConstraint?
	var promoView: UICollectionView!
	var categoriesCollectionView: UICollectionView!
	var interactor: IMenuInteractor?
	let cityLabel = UILabel()
	let arrowImage = UIImageView()
	
	var menuViewModel = MenuModel.ViewModel(categories: [], menuItems: [])
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		
		setUpCollectionView()
		setUpTableView()
		style()
		layout()
		setUpDependencies()
		
		interactor?.showCategories(selectedId: 0)
		interactor?.showMenuItems(for: "Beef", id: 0)
	}
	
	private func style() {
		headerView.translatesAutoresizingMaskIntoConstraints = false
		categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
		tableView.translatesAutoresizingMaskIntoConstraints = false
		promoView.translatesAutoresizingMaskIntoConstraints = false
		cityLabel.translatesAutoresizingMaskIntoConstraints = false
		arrowImage.translatesAutoresizingMaskIntoConstraints = false
		
		categoriesCollectionView.showsHorizontalScrollIndicator = false
		
		arrowImage.image = UIImage(named: "Arrow")
		cityLabel.text = "Moscow"
		cityLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
		cityLabel.textColor = .black
		view.backgroundColor = UIColor(named: "Background Grey")
		categoriesCollectionView.backgroundColor = UIColor(named: "Background Grey")
		promoView.backgroundColor = UIColor(named: "Background Grey")
	}
	
	private func layout() {
		
		view.addSubview(headerView)
		headerView.addSubview(categoriesCollectionView)
		headerView.addSubview(promoView)
		view.addSubview(tableView)
		view.addSubview(cityLabel)
		view.addSubview(arrowImage)
		
		headerViewTopConstraint = headerView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10)
		
		NSLayoutConstraint.activate([
			cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			
			arrowImage.centerYAnchor.constraint(equalTo: cityLabel.centerYAnchor),
			arrowImage.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 5),
			
			headerViewTopConstraint!,
			headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			headerView.heightAnchor.constraint(equalToConstant: 200),
			
			promoView.topAnchor.constraint(equalTo: headerView.topAnchor),
			promoView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
			promoView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
			promoView.heightAnchor.constraint(equalToConstant: 130),
			
			categoriesCollectionView.topAnchor.constraint(equalTo: promoView.bottomAnchor),
			categoriesCollectionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
			categoriesCollectionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
			categoriesCollectionView.heightAnchor.constraint(equalToConstant: 50),
			
			tableView.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor, constant: 10),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private func setUpCollectionView() {
		
		let layoutCategories = UICollectionViewFlowLayout()
		layoutCategories.scrollDirection = .horizontal
		layoutCategories.itemSize = CGSize(width: 130, height: 40)
		
		categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutCategories)
		categoriesCollectionView.delegate = self
		categoriesCollectionView.dataSource = self
		
		categoriesCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
		
		let layoutPromo = UICollectionViewFlowLayout()
		layoutPromo.scrollDirection = .horizontal
		layoutPromo.itemSize = CGSize(width: 350, height: 120)
		
		promoView = UICollectionView(frame: .zero, collectionViewLayout: layoutPromo)
		promoView.delegate = self
		promoView.dataSource = self
		
		promoView.register(PromoCollectionViewCell.self, forCellWithReuseIdentifier: "PromoCollectionViewCell")
	}
	
	private func setUpTableView(){
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MyCell")
	}
	
	private func setUpDependencies() {
		let worker = MenuWorker()
		let presenter = MenuPresenter(viewController: self)
		interactor = MenuInteractor(worker: worker, presenter: presenter)
	}
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView == promoView {
			return 2
		}else if collectionView == categoriesCollectionView {
			return menuViewModel.categories.count
		}
		fatalError("Unknown collection view")
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if collectionView == promoView {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromoCollectionViewCell", for: indexPath) as! PromoCollectionViewCell
			
			cell.promoImage.image = UIImage(named: "promo\(indexPath.row+1)")
			
			return cell
		}else if collectionView == categoriesCollectionView {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
			
			cell.label.text = menuViewModel.categories[indexPath.row].title
			
			if menuViewModel.categories[indexPath.row].status == .selected {
				cell.labelView.backgroundColor = UIColor(named: "Pale Pink")
				cell.labelView.layer.borderColor = UIColor(named: "Pale Pink")?.cgColor
				cell.label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
				cell.label.textColor = UIColor(named: "Pink")
			} else {
				cell.labelView.backgroundColor = UIColor(named: "Background Grey")
				cell.labelView.layer.borderColor = UIColor(named: "Light Pink")?.cgColor
				cell.label.font = UIFont.systemFont(ofSize: 16, weight: .light)
				cell.label.textColor = UIColor(named: "Light Pink")
			}
			
			return cell
		}
		fatalError("Unknown collection view")
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if collectionView == promoView {
			return CGSize(width: 350, height: 125)
		}else if collectionView == categoriesCollectionView {
			return CGSize(width: 100, height: 40)
		}
		fatalError("Unknown collection view")
		
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if collectionView == promoView {
			
		}else if collectionView == categoriesCollectionView {
			interactor?.showMenuItems(for: menuViewModel.categories[indexPath.row].title, id: indexPath.row)
			interactor?.showCategories(selectedId: indexPath.row)
		}
	}
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return menuViewModel.menuItems.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MenuTableViewCell
		
		cell.itemTitlelabel.text = menuViewModel.menuItems[indexPath.row].title
		cell.decriptionLabel.text = menuViewModel.menuItems[indexPath.row].composition
		cell.priceLabel.text = menuViewModel.menuItems[indexPath.row].price
		
		let imageStr = menuViewModel.menuItems[indexPath.row].imageString
		cell.itemImageView.sd_setImage(with: URL(string: imageStr))
		
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 180
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let y = scrollView.contentOffset.y
		
		let swipingDown = y <= 0
		let shouldStick = y > 30
		let promoViewHeight = 110
		
		UIView.animate(withDuration: 0.3) {
			self.promoView.alpha = swipingDown ? 1.0 : 0.0
		}
		
		UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, animations: {
			self.headerViewTopConstraint?.constant = CGFloat(shouldStick ? -promoViewHeight : 0)
			self.view.layoutIfNeeded()
		})
	}
}

extension MenuViewController: IMenuViewController {
	func renderMeals(viewModel: [MenuModel.ViewModel.MenuItem], id: Int) {
		menuViewModel.menuItems = viewModel
		tableView.reloadData()
	}
	
	func renderCategory(viewModel: [MenuModel.ViewModel.Category]) {
		menuViewModel.categories = viewModel
		categoriesCollectionView.reloadData()
	}
}
