//
//  MenuViewController.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//
// swiftlint: disable trailing_whitespace force_cast line_length
import UIKit
import Alamofire
/// протокол вью контроллера
protocol IMenuViewController {
	func renderCategory(viewModel: [MenuModel.ViewModel.Category])
	func renderMeals(viewModel: [MenuModel.ViewModel.MenuItem])
}

/// класс вью контроллера
class MenuViewController: UIViewController {

	/// список блюд
	private let tableView = UITableView()
	/// контейнер для коллекции промо и коллекции категорий
	private let headerView = UIView()
	/// ограничение верхнего края верхнего контейнера
	private var headerViewTopConstraint: NSLayoutConstraint?
	/// коллекция промо акций
	private var promoView: UICollectionView!
	/// коллекция категорий
	private var categoriesCollectionView: UICollectionView!
	/// текст названия города
	private let cityLabel = UILabel()
	/// картинка стрелочки возле названия города
	private let arrowImage = UIImageView()

	/// интерактор вью контроллера
	private var interactor: IMenuInteractor?
	/// вью модель контроллера
	var menuViewModel = MenuModel.ViewModel(categories: [], menuItems: [])
	
	init(interactor: IMenuInteractor) {
		super.init(nibName: nil, bundle: nil)
		self.interactor = interactor
	}
	
	required init?(coder: NSCoder) {
		fatalError(MenuStrings.initFatalError)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		setupCollectionView()
		setupTableView()
		style()
		layout()

		interactor?.showCategories(selectedId: MenuDigits.firstSelectedId)
		interactor?.showMenuItems(for: MenuStrings.firstFetchCategory)
	}

	private func style() {
		arrowImage.image = MenuImages.arrow
		cityLabel.text = MenuStrings.cityLabel
		cityLabel.font = UIFont.systemFont(ofSize: MenuDigits.cityLabelTextSize, weight: .medium)
		cityLabel.textColor = .black
		view.backgroundColor = MenuColors.greyBackground
		categoriesCollectionView.backgroundColor = MenuColors.greyBackground
		promoView.backgroundColor = MenuColors.greyBackground
	}
	
	private func layout() {
		headerView.translatesAutoresizingMaskIntoConstraints = false
		categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
		tableView.translatesAutoresizingMaskIntoConstraints = false
		promoView.translatesAutoresizingMaskIntoConstraints = false
		cityLabel.translatesAutoresizingMaskIntoConstraints = false
		arrowImage.translatesAutoresizingMaskIntoConstraints = false
		categoriesCollectionView.showsHorizontalScrollIndicator = false
		
		view.addSubview(headerView)
		headerView.addSubview(categoriesCollectionView)
		headerView.addSubview(promoView)
		view.addSubview(tableView)
		view.addSubview(cityLabel)
		view.addSubview(arrowImage)
		
		headerViewTopConstraint = headerView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: MenuDigits.leadingTrailingConstants)
		
		NSLayoutConstraint.activate([
			cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MenuDigits.leadingTrailingConstants),
			
			arrowImage.centerYAnchor.constraint(equalTo: cityLabel.centerYAnchor),
			arrowImage.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: MenuDigits.arrowImageLeadingConstant),
			
			headerViewTopConstraint!,
			headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			headerView.heightAnchor.constraint(equalToConstant: MenuDigits.headerViewHeight),
			
			promoView.topAnchor.constraint(equalTo: headerView.topAnchor),
			promoView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: MenuDigits.leadingTrailingConstants),
			promoView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -MenuDigits.leadingTrailingConstants),
			promoView.heightAnchor.constraint(equalToConstant: MenuDigits.promoViewHeight),
			
			categoriesCollectionView.topAnchor.constraint(equalTo: promoView.bottomAnchor),
			categoriesCollectionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: MenuDigits.leadingTrailingConstants),
			categoriesCollectionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
			categoriesCollectionView.heightAnchor.constraint(equalToConstant: MenuDigits.categoriesCollectionHeight),
			
			tableView.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor, constant: MenuDigits.leadingTrailingConstants),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private func setupCollectionView() {
		
		let layoutCategories = UICollectionViewFlowLayout()
		layoutCategories.scrollDirection = .horizontal
		layoutCategories.itemSize = CGSize(width: MenuDigits.categoriesCellWidth, height: MenuDigits.categoriesCellHeight)
		
		categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutCategories)
		categoriesCollectionView.delegate = self
		categoriesCollectionView.dataSource = self
		
		categoriesCollectionView.register(CategoryCollectionCell.self,
										  forCellWithReuseIdentifier: MenuStrings.categoriesCellIdentifier)
		
		let layoutPromo = UICollectionViewFlowLayout()
		layoutPromo.scrollDirection = .horizontal
		layoutPromo.itemSize = CGSize(width: MenuDigits.promoCellWidth, height: MenuDigits.promoCellHeight)
		
		promoView = UICollectionView(frame: .zero, collectionViewLayout: layoutPromo)
		promoView.delegate = self
		promoView.dataSource = self
		
		promoView.register(PromoCollectionCell.self, forCellWithReuseIdentifier: MenuStrings.promoCellIdentifier)
	}
	
	private func setupTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.register(MenuCell.self, forCellReuseIdentifier: MenuStrings.tableViewCellIdentifier)
	}

}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	/// реализация метода протокола UICollectionViewDataSource. возвращает количество ячеек в коллекции
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView == promoView {
			return MenuDigits.numberOfPromos
		} else if collectionView == categoriesCollectionView {
			return menuViewModel.categories.count
		}
		fatalError(MenuStrings.unknownColelctionViewError)
	}
	
	/// реализация метода протокола UICollectionViewDelegate. возвращает ячейки и определяет их интерфейс
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if collectionView == promoView {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuStrings.promoCellIdentifier,
														  for: indexPath) as! PromoCollectionCell
			cell.update(imageName: "promo\(indexPath.row+1)")
			
			return cell
		} else if collectionView == categoriesCollectionView {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuStrings.categoriesCellIdentifier,
														  for: indexPath) as! CategoryCollectionCell

			cell.update(title: menuViewModel.categories[indexPath.row].title, selected: menuViewModel.categories[indexPath.row].status)

			return cell
		}
		fatalError(MenuStrings.unknownColelctionViewError)
		
	}
	
	/// реализация метода протокола UICollectionViewDataSource. возвращает размер каждой ячейки
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if collectionView == promoView {
			return CGSize(width: MenuDigits.promoCellWidth, height: MenuDigits.promoCellHeight)
		} else if collectionView == categoriesCollectionView {
			return CGSize(width: MenuDigits.categoriesCellWidth, height: MenuDigits.categoriesCellHeight)
		}
		fatalError(MenuStrings.unknownColelctionViewError)
		
	}
	
	/// реализация метода протокола UICollectionViewDelegate. определяет поведение при нажатии на ячейку коллекции
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if collectionView == promoView {
			
		} else if collectionView == categoriesCollectionView {
			interactor?.showMenuItems(for: menuViewModel.categories[indexPath.row].title)
			interactor?.showCategories(selectedId: indexPath.row)
		}
	}
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
	/// реализация метода протокола UITableViewDataSource. возвращает количество ячеек в списке
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return menuViewModel.menuItems.count
	}
	
	/// реализация метода протокола UITableViewDelegate. возвращает ячейку для каждой строки в списке
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: MenuStrings.tableViewCellIdentifier, for: indexPath) as! MenuCell
		
		cell.update(viewModel: menuViewModel, index: indexPath.row)
		
		return cell
	}
	
	/// реализация метода протокола UITableViewDataSource. возвращает высоту каждой ячейки
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return MenuDigits.tableViewCellHeight
	}
	
	/// реализация метода протокола UITableViewDataSource. определяет поведение при нажатии на ячейку
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	/// метод, ответственный за прилипание верхнего контейнера к верхней части экрана при скролле
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let yPoint = scrollView.contentOffset.y
		
		let swipingDown = yPoint <= MenuDigits.scrollSwipeDown
		let shouldStick = yPoint > MenuDigits.scrollStickPoint
		let promoViewHeight = MenuDigits.promoCellHeight
		
		UIView.animate(withDuration: MenuDigits.animationDuration) {
			self.promoView.alpha = swipingDown ? 1.0 : 0.0
		}
		
		UIViewPropertyAnimator.runningPropertyAnimator(withDuration: MenuDigits.animationDuration, delay: MenuDigits.animationDelay, animations: {
			self.headerViewTopConstraint?.constant = CGFloat(shouldStick ? -promoViewHeight : MenuDigits.promoViewHeightWhenSticked)
			self.view.layoutIfNeeded()
		})
	}
}

extension MenuViewController: IMenuViewController {
	/// метод, инициирующий прогрузку списка блюд. viewModel - вью модель для отображения списка блюд
	/// //showMeals
	func renderMeals(viewModel: [MenuModel.ViewModel.MenuItem]) {
		menuViewModel.menuItems = viewModel
		tableView.reloadData()
	}
	
	/// метод, инициирующий прогрузку списка категорий. viewModel - вью модель для отображения списка категорий
	func renderCategory(viewModel: [MenuModel.ViewModel.Category]) {
		menuViewModel.categories = viewModel
		categoriesCollectionView.reloadData()
	}
}
