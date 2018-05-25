//
//  GameViewController+Animation.swift
//  StoryChap
//
//  Created by Carlos Marcelo Tonisso Junior on 5/22/18.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import UIKit

extension GameViewController {
    func changeScene(newScene currentScene: Scene){
        var transitionTimeIn = 0.5
        var transitionTimeOut = 0.5
        
        if let sceneAnimationTime = currentScene.transitionTimeIn {
            transitionTimeIn = sceneAnimationTime
        }
        
        if let sceneAnimationTime = currentScene.transitionTimeOut {
            transitionTimeOut = sceneAnimationTime
        }
        
        animateHideSceneText(duration: transitionTimeOut)
        
        self.label.text = currentScene.text
        if let currentImageForScene = currentScene.imageName {
            self.backgroundImage.image = UIImage(named: currentImageForScene)
        }
        
        if let x = currentScene.x, let y = currentScene.y,
            let width = currentScene.width, let height = currentScene.height {
            
            let textPosition = CGRect(x: x, y: y, width: width, height: height)
            self.label.frame = textPosition
            
        }
        
        if let color = currentScene.color {
            self.label.textColor = UIColor(hexa: color)
        }
        
        
        
        if let fontName = currentScene.fontName,
            let fontSize = currentScene.fontSize {
            self.label.font = UIFont(name: fontName, size: CGFloat(fontSize))
        }
        
        animateShowSceneText(duration: transitionTimeIn)
    }
    
    ///Function that animate the showing of the scene text
    func animateShowSceneText(duration: Double) {
        UIView.animate(withDuration: duration, animations: {
            self.label.alpha = 1
        }, completion: nil)
    }
    
    ///Function that animate the hide of the scene text
    func animateHideSceneText(duration: Double) {
        UIView.animate(withDuration: duration, animations: {
            self.label.alpha = 0
        }, completion: nil)
    }
}
