//
//  ShowMixerLed.swift
//  drumPad
//
//  Created by Olaf Kroon on 23/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import Foundation

class ShowMixerLed {
    
    init() {
        
    }
    
    func calculateLevel(currentLevel: Float) -> String {
        let level = String(format: "%.2f", (currentLevel - 0.5) * 10)
        let output = "DB:" + String(level)
        return output
    }
    
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
