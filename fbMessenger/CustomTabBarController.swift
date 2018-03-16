//
//  CustomTabBarController.swift
//  fbMessenger
//
//  Created by Kohei Arai on 2018/03/15.
//  Copyright © 2018年 Kohei Arai. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsViewController(collectionViewLayout: layout)
        let recentMessagesNavController = UINavigationController(rootViewController: friendsController)
        recentMessagesNavController.tabBarItem.title = "Recent"
        recentMessagesNavController.tabBarItem.image = UIImage(named: "recent")
        
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = "Calls"
        navController.tabBarItem.image = UIImage(named: "calls")
        
        
        viewControllers = [recentMessagesNavController, createDummyController(with: "Calls", imageName: "calls"), createDummyController(with: "Groups", imageName: "groups"), createDummyController(with: "People", imageName: "people"), createDummyController(with: "Settings", imageName: "settings")]
    }
    
    
    private func createDummyController(with title: String, imageName: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
    
    
}
