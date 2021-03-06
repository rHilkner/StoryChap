//
//  GameViewController+Animation.swift
//  StoryChap
//
//  Created by Carlos Marcelo Tonisso Junior on 5/22/18.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import UIKit
import AVFoundation

extension GameViewController {
    func changeScene(newScene currentScene: Scene) {
        // Ending last scene
        self.stopNarrationSound()

        // Starting current scene
        var transitionTimeIn = 0.5
        var transitionTimeOut = 0.5
        
        if let sceneAnimationTime = currentScene.primaryTransitionTimeIn {
            transitionTimeIn = sceneAnimationTime
        }
        
        if currentScene.secondaryTransitionTimeOut == nil {
            self.animateHideSceneText(label: labelPrimaryText, duration: transitionTimeOut)
        } else {
            self.animateHideSceneText(label: labelSecondaryText, duration: transitionTimeOut)
        }

        if let currentImageForScene = currentScene.imageName {
            self.backgroundImage.image = UIImage(named: currentImageForScene)
        }

        if let backgroundSoundForScene = currentScene.backgroundSoundName {
            self.playBackgroundSound(named: backgroundSoundForScene)
        }

        if let narrationSoundForScene = currentScene.narrationSoundName {
            self.playNarrationSound(named: narrationSoundForScene)
        }
        
        if currentScene.primaryText != nil {
            self.setTextForPrimaryLabel(currentScene)
        }
        
        if currentScene.secondaryText != nil {
            setTextForSecondaryLabel(currentScene)
        } else {
            self.labelSecondaryText.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        }
        
        if let sceneAnimationTime = currentScene.primaryTransitionTimeOut {
            transitionTimeOut = sceneAnimationTime
        }
        
        if currentScene.secondaryTransitionTimeIn == nil {
            animateShowSceneText(label: labelPrimaryText, duration: transitionTimeIn)
        } else {
            animateShowSceneText(label: labelSecondaryText, duration: transitionTimeIn)
        }
    }
    
    func setTextForPrimaryLabel(_ currentScene: Scene) {
        self.labelPrimaryText.text = currentScene.primaryText
        
        if let hasBorder = currentScene.primaryHasBorder {
            if (hasBorder) {
                self.labelPrimaryText.layer.borderWidth = 3.0
                self.labelPrimaryText.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.labelPrimaryText.layer.cornerRadius = 10
            } else {
                self.labelPrimaryText.layer.borderWidth = 0
            }
        }
        
        if let x = currentScene.primaryX, let y = currentScene.primaryY,
            let width = currentScene.primaryWidth, let height = currentScene.primaryHeight {
            
            let textPosition = CGRect(x: x, y: y, width: width, height: height)
            self.labelPrimaryText.frame = textPosition
            
        }
        
        if let color = currentScene.primaryColor {
            self.labelPrimaryText.textColor = UIColor(hexa: color)
            
        }
        
        if let fontName = currentScene.primaryFontName,
            let fontSize = currentScene.primaryFontSize {
            self.labelPrimaryText.font = UIFont(name: fontName, size: CGFloat(fontSize))
        }
    }
    
    func setTextForSecondaryLabel(_ currentScene: Scene) {
        
        self.labelSecondaryText.text = currentScene.secondaryText
        
        if let hasBorder = currentScene.secondaryHasBorder {
            if (hasBorder) {
                self.labelSecondaryText.layer.borderWidth = 3.0
                self.labelSecondaryText.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.labelSecondaryText.layer.cornerRadius = 10
            } else {
                self.labelSecondaryText.layer.borderWidth = 0
            }
        }
        
        if let x = currentScene.secondaryX, let y = currentScene.secondaryY,
            let width = currentScene.secondaryWidth, let height = currentScene.secondaryHeight {
            
            let textPosition = CGRect(x: x, y: y, width: width, height: height)
            self.labelSecondaryText.frame = textPosition
            
        }
        
        if let color = currentScene.secondaryColor {
            
            self.labelSecondaryText.textColor = UIColor(hexa: color)
        }
        
        if let fontName = currentScene.secondaryFontName,
            let fontSize = currentScene.secondaryFontSize {
            self.labelSecondaryText.font = UIFont(name: fontName, size: CGFloat(fontSize))
        }
    }
    
    ///Function that animate the showing of the scene text
    func animateShowSceneText(label: UILabel, duration: Double) {
        UIView.animate(withDuration: duration, animations: {
            label.alpha = 1
        }, completion: nil)
    }
    
    ///Function that animate the hide of the scene text
    func animateHideSceneText(label: UILabel,duration: Double) {
        UIView.animate(withDuration: duration, animations: {
            label.alpha = 0
        }, completion: nil)
    }

    /// Plays background sound of the game
    func playBackgroundSound(named soundName: String) {
        if soundName == "" {
            self.stopBackgroundSound()
            return
        }
        guard let soundAsset = NSDataAsset(name: soundName) else {
            print("-> WARNING: narration sound asset found nil")
            return
        }

        guard let backgroundSound = try? AVAudioPlayer(data: soundAsset.data, fileTypeHint: "mp3") else {
            print("-> WARNING: narration sound found nil")
            return
        }

        self.backgroundSound = backgroundSound
        // Looping background sound forever
        self.backgroundSound!.numberOfLoops = -1
        self.backgroundSound!.play()
    }

    /// Plays sound for narration of the game
    func playNarrationSound(named soundName: String) {
        guard let soundAsset = NSDataAsset(name: soundName) else {
            print("-> WARNING: narration sound asset found nil")
            return
        }

        guard let narrationSound = try? AVAudioPlayer(data: soundAsset.data, fileTypeHint: "mp3") else {
            print("-> WARNING: narration sound found nil")
            return
        }

        self.narrationSound = narrationSound
        self.narrationSound!.play()
    }

    /// Stops background sound of the game
    func stopBackgroundSound() {
        self.backgroundSound?.stop()
    }

    /// Stops sound for narration of the game
    func stopNarrationSound() {
        self.narrationSound?.stop()
    }
}
