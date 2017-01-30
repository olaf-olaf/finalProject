//
//  ShowMixerLed.swift
//  drumPad
//
//  Created by Olaf Kroon on 24/01/17.
//  Student number: 10787321
//  Course: Programmeerproject
//
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import Foundation

/**
 ShowMixerLed represents the red squares beneath every slider 
 in AudioMixerViewController.
 */
class ShowMixerLed {
    
    init() {
    }
    
    // Round the current level of a float and return that value in a string.
    func calculateLevel(currentLevel: Float) -> String {
        let level = String(format: "%.2f", (currentLevel - 0.5) * 10)
        let output = "DB:" + String(level)
        return output
    }
    
    // Check if currentPan is negative and return a string depending on true or false.
    func calculatePan(currentPan: Float) -> String {
        var output: String
        var displayPan = currentPan
        
        if currentPan < 0 {
            displayPan *= -1
            output = "L: " + String(displayPan)
        } else {
            output = "R: " + String(displayPan)
        }
        return output
    }
}
