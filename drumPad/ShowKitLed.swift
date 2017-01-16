//
//  ShowKitLed.swift
//  drumPad
//
//  Created by Olaf Kroon on 15/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import Foundation

//GEWOON EEN INSTANCE MAKEN IN DE AL BESTAANDE SINGLETON
class ShowKitLed {
    
    static let sharedInstance = ShowKitLed()
    let drumKits = ["808", "Funk", "Jazz","909"]
    var index = 0
    
    var displayKit: String
    private init () {
        
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
    
