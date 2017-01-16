//
//  ShowKitLed.swift
//  drumPad
//
//  Created by Olaf Kroon on 15/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import Foundation

class ShowKitLed {
    
    static let sharedInstance = ShowKitLed()
    
    
    let drumKits = ["808","909","Jazz"]
    var index = 0
    
    var displayKit: String
    private init () {
        
        displayKit = drumKits[0]
    }
    
    func displayNext() {
        if index == drumKits.count - 1 {
            index = 0
        } else {
            self.index += 1
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
    
