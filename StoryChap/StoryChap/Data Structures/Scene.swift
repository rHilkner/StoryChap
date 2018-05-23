//
//  Scene.swift
//  StoryChap
//
//  Created by Rodrigo Hilkner on 16/05/18.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import UIKit

struct Scene: Decodable {
    let imageName: String?
    let text: String
    let x: Double?
    let y: Double?
    let width: Double?
    let height: Double?
    let color: String?
    let fontName: String?
    let fontSize: Double?
    let transitionTimeIn: Double?
    let transitionTimeOut: Double?
}
