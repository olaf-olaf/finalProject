//
//  MixerParameters.swift
//  drumPad
//
//  Created by Olaf Kroon on 26/01/17.
//  Student number: 10787321
//  Course: Programmeerproject
//
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import Foundation

// MixerLevels is a class that bundles related values in an object.
class MixerLevels {
    var kickLevel: Float
    var snareLevel: Float
    var tomLevel: Float
    var hatLevel: Float
    
    init (kickLevel: Float, snareLevel: Float, tomLevel: Float, hatLevel: Float) {
        self.kickLevel = kickLevel
        self.snareLevel = snareLevel
        self.tomLevel = tomLevel
        self.hatLevel = hatLevel
    }
}

// MixerPanning is a class that bundles related values in an object.
class MixerPanning {
    var kickPan: Float
    var snarePan: Float
    var tomPan: Float
    var hatPan: Float
    
    init (kickPan: Float, snarePan: Float, tomPan: Float, hatPan: Float){
        self.kickPan = kickPan
        self.snarePan = snarePan
        self.tomPan = tomPan
        self.hatPan = hatPan
    }
}

