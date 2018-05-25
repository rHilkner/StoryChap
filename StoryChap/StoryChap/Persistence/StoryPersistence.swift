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

        guard let newStory = decodeJson() else {
            return []
        }
        
        return [newStory]
    }

    static func decodeJson() -> Story? {

        // Reading JSON data as dictionary
        let path = Bundle.main.url(forResource: "mondark", withExtension: "json")

        let storyDictionary: [String : Any]

        do {
            let data = try Data(contentsOf: path!)
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            storyDictionary = jsonData as! [String : Any]

        } catch {
            print("-> WARNING: Error when converting JSON to dictionary.")
            return nil
        }

        // Reading story information from dictionary
        guard let id = storyDictionary["id"] as? String,
              let title = storyDictionary["title"] as? String,
              let titleImageName = storyDictionary["titleImageName"] as? String,
              let thumbnailImageName = storyDictionary["thumbnailImageName"] as? String,
              let description = storyDictionary["description"] as? String,
              let possibleChars = storyDictionary["possibleCharacters"] as? [[String : Any]] else {
            print("-> WARNING: Error when reading story dictionary.")
            return nil
        }

        // Reading list of possible characters for the story
        var possibleCharacters = [Character]()

        for character in possibleChars {
            guard let characterName = character["name"] as? String else {
                print("-> WARNING: Error when reading character dictionary.")
                return nil
            }

            let char = Character(name: characterName, currentEvent: nil)
            possibleCharacters.append(char)
        }

        // Getting dictionary of events
        guard let initialEventId = storyDictionary["initialEvent"] as? String,
              let eventsDict = storyDictionary["events"] as? [[String : Any]] else {
            print("-> WARNING: Error when reading story dictionary.")
            return nil
        }

        // Reading events of the story
        var events = [Event]()
        var eventTree = [String : [String]]()
        var eventsReferencedById = [String : Event]()

        for eventDict in eventsDict {
            guard let eventId = eventDict["id"] as? String,
                  let optionText = eventDict["optionText"] as? String,
                  let scenesDict = eventDict["scenes"] as? [[String : Any]] else {
                print("-> WARNING: Error when reading event dictionary.")
                return nil
            }

            // Getting scenes of the event
            var scenes = [Scene]()

            for sceneDict in scenesDict {
                
                // Adding scene to list of scenes
//                let scene = Scene(primaryText: sceneText, imageName: imageName, x: x, y: y, width: width, height: height, color: color, fontName: fontName, fontSize: fontSize, transitionTimeIn: transitionTimeIn, transitionTimeOut: transitionTimeOut, hasBorder: hasBorder)
                
                let scene = buildScene(sceneDictionary: sceneDict)
                scenes.append(scene)
            }

            // Creating event and appending to array of events
            let event = Event(id: eventId, optionText: optionText, scenes: scenes, nextPossibleEvents: [])
            events.append(event)

//            guard let nextPossibleEvents = eventDict["nextPossibleEvents"] as? [String] else {
//                print("-> WARNING: Error when reading event dictionary.")
//                return nil
//            }
            
            if let nextPossibleEvents = eventDict["nextPossibleEvents"] as? [String] {
                eventTree[event.id] = nextPossibleEvents
            } else {
                eventTree[event.id] = []
            }

            eventsReferencedById[event.id] = event
        }

        var initialEvent: Event!

        for event in events {
            // Finding initial event
            if event.id == initialEventId {
                initialEvent = event
            }

            // Building events graph
            for nextEventId in eventTree[event.id]! {
                event.nextPossibleEvents.append(eventsReferencedById[nextEventId]!)
            }
        }

        // Returning story
        let story = Story(id: id,
                          title: title,
                          description: description,
                          titleImageName: titleImageName,
                          thumbnailImageName: thumbnailImageName,
                          possibleCharacters: possibleCharacters,
                          initialEvent: initialEvent)

        return story
    }

    static func buildScene(sceneDictionary: [String : Any]) -> Scene {
        let primaryText = sceneDictionary["primaryText"] as? String
        let imageName = sceneDictionary["imageName"] as? String
        let primaryX = sceneDictionary["primaryX"] as? Double
        let primaryY = sceneDictionary["primaryY"] as? Double
        let primaryWidth = sceneDictionary["primaryWidth"] as? Double
        let primaryHeight = sceneDictionary["primaryHeight"] as? Double
        let primaryColor = sceneDictionary["primaryColor"] as? String
        let primaryFontName = sceneDictionary["primaryFontName"] as? String
        let primaryFontSize = sceneDictionary["primaryFontSize"] as? Double
        let primaryTransitionTimeIn = sceneDictionary["primaryTransitionTimeIn"] as? Double
        let primaryTransitionTimeOut = sceneDictionary["primaryTransitionTimeOut"] as? Double
        let primaryHasBorder = sceneDictionary["primaryHasBorder"] as? Bool
        let secondaryText = sceneDictionary["secondaryText"] as? String
        let secondaryX = sceneDictionary["secondaryX"] as? Double
        let secondaryY = sceneDictionary["secondaryY"] as? Double
        let secondaryColor = sceneDictionary["secondaryColor"] as? String
        let secondaryWidth = sceneDictionary["secondaryWidth"] as? Double
        let secondaryHeight = sceneDictionary["secondaryHeight"] as? Double
        let secondaryFontName = sceneDictionary["secondaryFontName"] as? String
        let secondaryFontSize = sceneDictionary["secondaryFontSize"] as? Double
        let secondaryTransitionTimeIn = sceneDictionary["secondaryTransitionTimeIn"] as? Double
        let secondaryTransitionTimeOut = sceneDictionary["secondaryTransitionTimeOut"] as? Double
        let secondaryHasBorder = sceneDictionary["secondaryHasBorder"] as? Bool
        
        var scene = Scene()
        
        scene.primaryText = primaryText
        scene.imageName = imageName
        scene.primaryX = primaryX
        scene.primaryY = primaryY
        scene.primaryWidth = primaryWidth
        scene.primaryHeight = primaryHeight
        scene.primaryColor = primaryColor
        scene.primaryFontName = primaryFontName
        scene.primaryFontSize = primaryFontSize
        scene.primaryTransitionTimeIn = primaryTransitionTimeIn
        scene.primaryTransitionTimeOut = primaryTransitionTimeOut
        scene.primaryHasBorder = primaryHasBorder
        
        scene.secondaryText = secondaryText
        scene.secondaryX = secondaryX
        scene.secondaryY = secondaryY
        scene.secondaryWidth = secondaryWidth
        scene.secondaryHeight = secondaryHeight
        scene.secondaryColor = secondaryColor
        scene.secondaryFontName = secondaryFontName
        scene.secondaryFontSize = secondaryFontSize
        scene.secondaryTransitionTimeIn = secondaryTransitionTimeIn
        scene.secondaryTransitionTimeOut = secondaryTransitionTimeOut
        scene.secondaryHasBorder = secondaryHasBorder
        
        return scene
    }

}
