//
//  ShowKitLed.swift
//  drumPad
//
//  Created by Olaf Kroon on 15/01/17.
//  Student number: 10787321
//  Course: Programmeerproject
//
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import Foundation

/**
 ShowKitLed represents the red square on the main view of this app.
 It can display one of the kits in drumKits. To add a new drumkit simply
 upload the samples and add the name of the kit to drumKits. 
 */
class ShowKitLed {
    let drumKits = ["808","909","606","Funk","Jazz","Techno"]
    var index = 0
    var displayKit: String
    
    init () {
        displayKit = drumKits[0]
    }
    
    // Updates displayKit with the next element in drumKits.
    func displayNext() {
        if index == drumKits.count - 1 {
            index = 0
        } else {
            index += 1
        }
        displayKit = drumKits[index]
    }
    
    // Updates displayKit with the previous element in drumKits.
    func displayPrevious() {
        if index == 0 {
            index = drumKits.count - 1
        } else {
            index -= 1
        }
        displayKit = drumKits[index]
    }
}
    
