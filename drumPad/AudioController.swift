//
//  AudioController.swift
//  drumPad
//
//  Created by Olaf Kroon on 12/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import Foundation
import AudioKit

class AudioController {
    
    static let sharedInstance = AudioController()
    
    
    let FxMixControls = Fxparameters()
    
    let kickFile = try! AKAudioFile(readFileName: "808Kick.wav")
    let snareFile = try! AKAudioFile(readFileName: "808Snare.wav")
    let hatFile = try! AKAudioFile(readFileName: "808HiHat.wav")
    let tomFile = try! AKAudioFile(readFileName: "808Tom.wav")
    
    var kickPlayer: AKAudioPlayer
    var snarePlayer: AKAudioPlayer
    var hatPlayer: AKAudioPlayer
    var tomPlayer: AKAudioPlayer
    let mixer: AKMixer
    var reverb: AKReverb
    var distortion: AKDistortion
    var ringModulator: AKRingModulator


    // Start audiokit within the initialisation of a singleton to prevent latency and crashes.
    private init() {
        kickPlayer = try! AKAudioPlayer(file: kickFile)
        snarePlayer = try! AKAudioPlayer(file: snareFile)
        hatPlayer = try! AKAudioPlayer(file: hatFile)
        tomPlayer = try! AKAudioPlayer(file: tomFile)
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
        let newHatFile = try! AKAudioFile(readFileName: kitName+"HiHat.wav")
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
    
    func setReverbDryWet(level: Float) {
        reverb.dryWetMix = Double(level)
        AudioController.sharedInstance.FxMixControls.reverbMix = Double(level)
    }
    
    func setDistortionDryWet(level: Float) {
    distortion.finalMix = Double(level)
        AudioController.sharedInstance.FxMixControls.distortionMix = Double(level)
    }
    
    func setRingModulaterDryWet (level: Float) {
        ringModulator.mix = Double(level)
        AudioController.sharedInstance.FxMixControls.ringMix = Double(level)
    }

    

}
