//
//  ViewControllerFactory.swift
//  StoryChap
//
//  Created by Rodrigo Hilkner on 15/05/18.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import UIKit

public enum ViewControllerType: String {
    case menu = "MenuViewController"
    case storyDetails = "StoryDetailsViewController"
    case game = "GameViewController"
}

class ViewControllerFactory {

    static func instantiateViewController(ofType type: ViewControllerType) -> UIViewController {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        switch type {

        case .menu:
            let viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerType.menu.rawValue) as! MenuViewController
            return viewController

        case .storyDetails:
            let viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerType.storyDetails.rawValue) as! StoryDetailsViewController
            return viewController

        case .game:
            let viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerType.game.rawValue)
            return viewController
        }
    }
}
