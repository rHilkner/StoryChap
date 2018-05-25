//
//  MenuController+FocusGuide.swift
//  StoryChap
//
//  Created by Rhullian Damião on 22/05/2018.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import UIKit

private struct RestorationIds {
    static let favCell = "favCell"
    static let menuCell = "menuCell"
}
extension MenuViewController {
    /// Function call when the focus change in the screen
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        guard let cell = context.nextFocusedItem as? UICollectionViewCell else {
            return
        }
        checkWhichCellIsFocused(collectionCell: cell)
    }
    
    ///Function used to check which kind of cell is focused
    private func checkWhichCellIsFocused(collectionCell cell:UICollectionViewCell) {
        switch cell.restorationIdentifier {
        case RestorationIds.favCell:
            if !firstScroll{
                animateReduceMenuCollectionVew()
                self.firstScroll = true
            }
        case RestorationIds.menuCell:
            if firstScroll {
                self.animateExpandMenuCollectionVew()
                self.firstScroll = false
            }
        default:
            return
        }
    }
    
    
}
