//
//  TabController.swift
//  TestMenu
//
//  Created by Dmitry Serebrov on 04.04.2023.
//
// swiftlint: disable trailing_whitespace
import Foundation
import UIKit
class TabViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let tabBarController = MyTabBarController()
		self.addChild(tabBarController)
		self.view.addSubview(tabBarController.view)
		tabBarController.didMove(toParent: self)
	}
	
}

class MyTabBarController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let firstVC = MenuViewController()
		let secondVC = SecondViewController()
		let thirdVC = ThirdViewController()
		let forthVC = ForthViewController()
		
		firstVC.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(named: "Menu"), selectedImage: nil)
		
		secondVC.tabBarItem = UITabBarItem(title: "Contacts", image: UIImage(named: "Contacts"), selectedImage: nil)
		
		thirdVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "Union"), selectedImage: nil)
		
		forthVC.tabBarItem = UITabBarItem(title: "Bin", image: UIImage(named: "Bin"), selectedImage: nil)
		
		UITabBar.appearance().tintColor = UIColor(named: "Pink")
		UITabBar.appearance().backgroundColor = .white
		
		self.viewControllers = [firstVC, secondVC, thirdVC, forthVC]
	}
}

class SecondViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
	}
}

class ThirdViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
	}
}

class ForthViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
	}
}
