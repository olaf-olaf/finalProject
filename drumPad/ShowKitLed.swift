//
//  ShowKitLed.swift
//  drumPad
//
//  Created by Olaf Kroon on 15/01/17.
//  Student number: 10787321
//  Course: Programmeerproject
//
//  ShowKitLed.swift contains the ShowKitLed class that is used to represent the kit that is used.
//
//  Copyright © 2017 Olaf Kroon. All rights reserved.


import Foundation

/**
 ShowKitLed represents the red square on the main view of this app.It displays 
 one of the kits in drumKits.
 */
class ShowKitLed {
    let drumKits = ["808","909","606","Funk","Jazz","Techno"]
    var index = 0
    var displayKit: String
    
    init () {
        displayKit = drumKits[0]
    }
    
    func displayNext() {
        if index == drumKits.count - 1 {
            index = 0
        } else {
            index += 1
        }
        displayKit = drumKits[index]
    }
    
    func displayPrevious() {
        if index == 0 {
            index = drumKits.count - 1
        } else {
            index -= 1
        }
        displayKit = drumKits[index]
    }
}
    
