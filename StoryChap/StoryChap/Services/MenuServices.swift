//
//  File.swift
//  StoryChap
//
//  Created by Rodrigo Hilkner on 15/05/18.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import Foundation

class MenuServices {

    static func allStories() -> [Story] {
        return StoryPersistence.allStories()
    }
}
