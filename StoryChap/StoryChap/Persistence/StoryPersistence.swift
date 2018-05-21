//
//  StoryPersistence.swift
//  StoryChap
//
//  Created by Rodrigo Hilkner on 15/05/18.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import UIKit

class StoryPersistence {

    static func allStories() -> [Story] {
//        let initialScene = Scene(
////            image: UIImage(),
//                                 text: "This is the first scene ever! Xupita is awesome btw...")
//
//        let secondScene = Scene(
////            image: UIImage(),
//                                 text: "This is the second scene ever! Xupita is still awesome btw...")
//
//        let nextScene = Scene(
////            image: UIImage(),
//                              text: "This is the scene of the next option! Xupita is god...")
//
//        let nextScene2 = Scene(
////            image: UIImage(),
//                              text: "This is the scene of the next option! Xupita is god...")
//
//        let secondEvent = Event(id: "2",
//                                optionText: "escolhe eu pls",
//                                scenes: [nextScene],
//                                nextPossibleEvents: [])
//
//        let thirdEvent = Event(id: "3",
//                                optionText: "escolhe eu pls2",
//                                scenes: [nextScene2],
//                                nextPossibleEvents: [])
//
//        let initialEvent = Event(id: "1",
//                                 optionText: "escolhe eu carai",
//                                 scenes: [initialScene, secondScene],
//                                 nextPossibleEvents: [secondEvent, thirdEvent])
//
//        let story = Story(id: "aa",
//                          title: "M.O.N.D.A.R.K.",
//                          description: "This is so black mirror",
////                          numberOfPlayers: (1...1),
////                          titleImage: UIImage(),
////                          thumbnailImage: UIImage(),
////                          coverImage: UIImage(),
//                          possibleCharacters: [],
//                          initialEvent: initialEvent)

        let newStory = decodeJson()
        
        return [newStory]
//        } else {
//            return [story, story, story, story, story, story, story, story, story, story, story, story]
//        }
    }
    
    static func decodeJson() -> Story {
        
        let path = Bundle.main.url(forResource: "mondark", withExtension: "json")
        
        var jsonData: Story?
        
            do {
                
                let data = try Data(contentsOf: path!)
                let decoder = JSONDecoder()
                jsonData = try decoder.decode(Story.self, from: data)
                
            } catch let error {
                print(error)
            }
        
        return jsonData!
    }
}
