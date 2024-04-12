//
//  CommonTabBarHandler.swift
//  Harit_Thoriya_FE_8953007
//
//  Created by thor on 2023-12-07.
//

import UIKit

class CommonTabBarHandler {
    
    static func tabSelection(for item: UITabBarItem, navigationController: UINavigationController?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch item.title {
        case "News":
            print("First")
            if let newsTableViewController = storyboard.instantiateViewController(withIdentifier: "News") as? NewsViewController {
                navigateToViewController(viewController: newsTableViewController, navigationController: navigationController)
            }

        case "Map":
            print("Second")
            if let mapViewController = storyboard.instantiateViewController(withIdentifier: "Map") as? MapViewController {
                navigateToViewController(viewController: mapViewController, navigationController: navigationController)
            }

        case "Weather":
            print("Third")
            if let weatherViewController = storyboard.instantiateViewController(withIdentifier: "Weather") as? WeatherViewController {
                navigateToViewController(viewController: weatherViewController, navigationController: navigationController)
            }

        default:
            break
        }
    }


    private static func navigateToViewController(viewController: UIViewController, navigationController: UINavigationController?) {
        navigationController?.pushViewController(viewController, animated: false)
    }
}
