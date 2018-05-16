//
//  Story.swift
//  StoryChap
//
//  Created by Rodrigo Hilkner on 14/05/18.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import UIKit

struct Story {
    let id: String
    let title: String
    let description: String
    let numberOfPlayers: CountableClosedRange<Int>

    let titleImage: UIImage
    let thumbnailImage: UIImage
    let coverImage: UIImage

    let possibleCharacters: [Character]
    let initialEvent: Event
}
