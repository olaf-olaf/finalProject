//
//  DrumPadClass.swift
//  drumPad
//
//  Created by Olaf Kroon on 11/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import Foundation
import AudioKit



class DrumPadClass {
    
    let bundle = Bundle.main
    
    init () {
    }
    
    func play(fileName: String) -> AKAudioPlayer {
    
        let audioFile = try! AKAudioFile(readFileName: fileName)
        let player = try! AKAudioPlayer(file: audioFile)
        print ("PLAYER", player)
        return player
    }
    
//    let audioFile = try! AKAudioFile(readFileName: fileName)
//    let player = try! AKAudioPlayer(file: audioFile)


  
    

}
