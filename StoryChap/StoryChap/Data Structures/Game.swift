//
//  Game.swift
//  StoryChap
//
//  Created by Rodrigo Hilkner on 14/05/18.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import Foundation

struct Game {
    let id: String
    let story: Story
    var currentEvent: Event?
    let numberOfPlayers: Int?
    let characters: [Character]?
}
