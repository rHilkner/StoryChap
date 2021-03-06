//
//  Decision.swift
//  StoryChap
//
//  Created by Rodrigo Hilkner on 14/05/18.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import UIKit

class Event {
    let id: String
    let optionText: String
    let scenes: [Scene]
    var nextPossibleEvents: [Event]

    init(id: String, optionText: String, scenes: [Scene], nextPossibleEvents: [Event]) {
        self.id = id
        self.optionText = optionText
        self.scenes = scenes
        self.nextPossibleEvents = nextPossibleEvents
    }
}
