//
//  Utils.swift
//  StoryChap
//
//  Created by Carlos Marcelo Tonisso Junior on 5/22/18.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init (hexa: String) {
    
        let colors = hexa.split(separator: ",")
        
        let red = CGFloat((colors[0] as NSString).doubleValue) / 255
        let green = CGFloat((colors[1] as NSString).doubleValue) / 255
        let blue = CGFloat((colors[2] as NSString).doubleValue) / 255
        let alpha = CGFloat((colors[3] as NSString).doubleValue) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}
