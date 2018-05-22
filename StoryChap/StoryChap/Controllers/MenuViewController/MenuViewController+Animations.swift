//
//  MenuViewController+Animations.swift
//  StoryChap
//
//  Created by Rhullian Damião on 22/05/2018.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import UIKit

extension MenuViewController {
    /// Function resposible for doing the expantion of menu collection view
    func animateExpandMenuCollectionVew() {
        self.menuCollectionHeightConstraint.constant += 900
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    /// Function resposible for doing the expantion of menu collection view
    func animateReduceMenuCollectionVew() {
        self.menuCollectionHeightConstraint.constant -= 900
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
