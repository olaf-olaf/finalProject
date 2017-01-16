//
//  AudioController.swift
//  drumPad
//
//  Created by Olaf Kroon on 12/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.

import Foundation
import AudioKit

class AudioController {
    
    static let sharedInstance = AudioController()

    let LEDKitSelector = ShowKitLed()
    
    let kickFile = try! AKAudioFile(readFileName: "808Kick.wav")
    let snareFile = try! AKAudioFile(readFileName: "808Snare.wav")
    let hatFile = try! AKAudioFile(readFileName: "808Hat.wav")
    let tomFile = try! AKAudioFile(readFileName: "808Tom.wav")
    
    var kickPlayer: AKAudioPlayer
    var snarePlayer: AKAudioPlayer
    var hatPlayer: AKAudioPlayer
    var tomPlayer: AKAudioPlayer
    let mixer: AKMixer
    var reverb: AKReverb
    var distortion: AKDistortion
    var ringModulator: AKRingModulator


    // Initialise Audiokit within the initialisation of a singleton to prevent latency and crashes.
    private init() {
        kickPlayer = try! AKAudioPlayer(file: kickFile)
        kickPlayer.volume = 0.5
        snarePlayer = try! AKAudioPlayer(file: snareFile)
        snarePlayer.volume = 0.5
        hatPlayer = try! AKAudioPlayer(file: hatFile)
        hatPlayer.volume = 0.5
        tomPlayer = try! AKAudioPlayer(file: tomFile)
        tomPlayer.volume = 0.5
        mixer = AKMixer(kickPlayer, snarePlayer, hatPlayer, tomPlayer)
        ringModulator = AKRingModulator(mixer)
        ringModulator.mix = 0
        distortion = AKDistortion(ringModulator)
        distortion.finalMix = 0
        reverb = AKReverb(distortion)
        reverb.dryWetMix = 0
        AudioKit.output = reverb
        AudioKit.start()
    }
    
    
    func replaceKit(kitName: String) {
        let newKickFile = try! AKAudioFile(readFileName: kitName+"Kick.wav")
        let newSnareFile = try! AKAudioFile(readFileName: kitName+"Snare.wav")
        let newHatFile = try! AKAudioFile(readFileName: kitName+"Hat.wav")
        let newTomFile = try! AKAudioFile(readFileName: kitName+"Tom.wav")
        
        do {
            try kickPlayer.replace(file: newKickFile)
            try snarePlayer.replace(file: newSnareFile)
            try hatPlayer.replace(file: newHatFile)
            try tomPlayer.replace(file: newTomFile)
            
        } catch {
            print (error)
        }
    }
    
    
    func mixFx(reverbLevel: Float, distortionLevel: Float, ringLevel: Float){
        reverb.dryWetMix = Double(reverbLevel)
        distortion.finalMix = Double(distortionLevel)
        ringModulator.mix = Double(ringLevel)
    }

    
    func mixAudio (kickVolume: Float, snareVolume: Float, tomVolume: Float, hatVolume: Float,  Kickpan: Float, snarePan: Float, tomPan: Float, hatPan: Float){
        kickPlayer.volume = Double(kickVolume)
        kickPlayer.pan = Double (Kickpan)
        snarePlayer.volume = Double(snareVolume)
        snarePlayer.pan = Double(snarePan)
        tomPlayer.volume = Double(tomVolume)
        tomPlayer.pan = Double(tomPan)
        hatPlayer.volume = Double(hatVolume)
        hatPlayer.pan = Double(hatPan)
    }
}
