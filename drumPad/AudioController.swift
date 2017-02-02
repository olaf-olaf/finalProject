//
//  AudioController.swift
//  drumPad
//
//  Created by Olaf Kroon on 12/01/17.
//  Student number: 10787321
//  Course: Programmeerproject
//
//  AudioController.swift contains a sample based synthesizer that provides all audio of this application.
//
//  Copyright © 2017 Olaf Kroon. All rights reserved.

import Foundation
import AudioKit

/*
AudioController is a singleton that represents a
sample based synthesizer.
**/
class AudioController {
    
    // MARK: - Variables.
    // Initialise Audiokit within the initialisation of a singleton to prevent latency and crashes.
    static let sharedInstance = AudioController()
    let LEDKitSelector = ShowKitLed()
    
    let kickFile = try! AKAudioFile(readFileName: "808Kick.wav")
    let snareFile = try! AKAudioFile(readFileName: "808Snare.wav")
    let hatFile = try! AKAudioFile(readFileName: "808Hat.wav")
    let tomFile = try! AKAudioFile(readFileName: "808Tom.wav")
    
    // Initialise a backup player for every player to allow double taps.
    var kickPlayer: AKAudioPlayer
    var backupKickPlayer: AKAudioPlayer
    var snarePlayer: AKAudioPlayer
    var backupSnarePlayer: AKAudioPlayer
    var hatPlayer: AKAudioPlayer
    var backupHatPlayer: AKAudioPlayer
    var tomPlayer: AKAudioPlayer
    var backupTomPlayer: AKAudioPlayer
    
    let mixer: AKMixer
    var reverb: AKReverb2
    var distortion: AKDistortion
    var ringModulator: AKRingModulator
    var delay: AKDelay
    let finalMixer: AKMixer
    var currentFrequency = 120.0
    
    let generator = AKOperationGenerator() { parameters in
        let beep = AKOperation.sineWave(frequency: 480)
    
        let metronome = AKOperation.metronome(frequency: parameters[0] / 60)
    
        let beeps = beep.triggeredWithEnvelope(
            trigger: metronome,
            attack: 0.01, hold: 0, release: 0.05)
        return beeps
    }
    
    // MARK: - Init.
    private init() {
        kickPlayer = try! AKAudioPlayer(file: kickFile)
        kickPlayer.volume = 0.5
        backupKickPlayer = try! AKAudioPlayer(file: kickFile)
        backupKickPlayer.volume = 0.5
        
        snarePlayer = try! AKAudioPlayer(file: snareFile)
        snarePlayer.volume = 0.5
        backupSnarePlayer = try! AKAudioPlayer(file: snareFile)
        backupSnarePlayer.volume = 0.5
        
        hatPlayer = try! AKAudioPlayer(file: hatFile)
        hatPlayer.volume = 0.5
        backupHatPlayer = try! AKAudioPlayer(file: hatFile)
        backupHatPlayer.volume = 0.5
        
        tomPlayer = try! AKAudioPlayer(file: tomFile)
        tomPlayer.volume = 0.5
        backupTomPlayer = try! AKAudioPlayer(file: tomFile)
        backupTomPlayer.volume = 0.5
        
        mixer = AKMixer(kickPlayer, snarePlayer, hatPlayer, tomPlayer, backupKickPlayer, backupSnarePlayer, backupHatPlayer, backupTomPlayer)
        
        ringModulator = AKRingModulator(mixer)
        ringModulator.mix = 0
        distortion = AKDistortion(ringModulator)
        distortion.finalMix = 0
        reverb = AKReverb2(distortion)
        reverb.dryWetMix = 0
        delay = AKDelay(reverb)
        delay.presetShortDelay()
        delay.dryWetMix = 0
        
        generator.parameters = [currentFrequency]
        finalMixer = AKMixer(delay, generator)
        AudioKit.output = finalMixer
        AudioKit.start()
        
        setReverbParameters(randomInflections: 20.00, maxDelay: 0.20, Decay: 0.5)
        setDelayParameters(delayTime: 0.1, delayFeedback: 0.01)
        setRingParameters(ringFrequencyOne: 100, ringFrequencyTwo: 103)
        setDistortionParameters(distortionDecimation: 0.05, distortionRouding: 0.1)
    }
    
    // MARK: - Methods.
    func replaceKit(kitName: String) {
        let newKickFile = try! AKAudioFile(readFileName: kitName+"Kick.wav")
        let newSnareFile = try! AKAudioFile(readFileName: kitName+"Snare.wav")
        let newHatFile = try! AKAudioFile(readFileName: kitName+"Hat.wav")
        let newTomFile = try! AKAudioFile(readFileName: kitName+"Tom.wav")
        do {
            try kickPlayer.replace(file: newKickFile)
            try backupKickPlayer.replace(file: newKickFile)
            try snarePlayer.replace(file: newSnareFile)
            try backupSnarePlayer.replace(file: newSnareFile)
            try hatPlayer.replace(file: newHatFile)
            try backupHatPlayer.replace(file: newHatFile)
            try tomPlayer.replace(file: newTomFile)
            try backupTomPlayer.replace(file: newTomFile)
        } catch {
            print (error)
        }
    }
    
    func mixFx(reverbLevel: Float, distortionLevel: Float, ringLevel: Float, delayLevel: Float){
        reverb.dryWetMix = Double(reverbLevel)
        distortion.finalMix = Double(distortionLevel)
        ringModulator.mix = Double(ringLevel)
        delay.dryWetMix = Double(delayLevel)
    }
    
    func mixAudio(levels: MixerLevels, panning: MixerPanning){
        kickPlayer.volume = Double(levels.kickLevel)
        backupKickPlayer.volume = Double(levels.kickLevel)
        kickPlayer.pan = Double(panning.kickPan)
        backupKickPlayer.pan = Double(panning.kickPan)
        
        snarePlayer.volume = Double(levels.snareLevel)
        backupSnarePlayer.volume = Double(levels.snareLevel)
        snarePlayer.pan = Double(panning.snarePan)
        backupSnarePlayer.pan = Double(panning.snarePan)
        
        tomPlayer.volume = Double(levels.tomLevel)
        backupTomPlayer.volume = Double(levels.tomLevel)
        tomPlayer.pan = Double(panning.tomPan)
        backupTomPlayer.pan  = Double(panning.tomPan)
        
        hatPlayer.volume = Double(levels.hatLevel)
        backupHatPlayer.volume = Double(levels.hatLevel)
        hatPlayer.pan = Double(panning.hatPan)
        backupHatPlayer.pan = Double(panning.hatPan)
    }

    func setMetronome() {
        if generator.isStarted {
            generator.stop()
        } else {
            generator.start()
        }
    }
    
    func playSample(player: AKAudioPlayer, backupPlayer: AKAudioPlayer){
        if player.isStarted {
            backupPlayer.play()
        } else {
            player.play()
        }
    }

    func setReverbParameters(randomInflections: Double, maxDelay: Double, Decay: Double) {
        reverb.gain = 10
        reverb.minDelayTime = 0.009
        reverb.decayTimeAt0Hz = 1.0
        reverb.maxDelayTime = maxDelay
        reverb.decayTimeAtNyquist = Decay
        reverb.randomizeReflections = randomInflections
    }

    func setMetronomeTempo(bpm: Float){
        currentFrequency = Double(bpm)
        generator.parameters = [currentFrequency]
    }
    
    func setDelayParameters(delayTime: Double, delayFeedback: Double){
        delay.time = delayTime
        delay.feedback = delayFeedback
    }
    
    func setRingParameters(ringFrequencyOne: Double, ringFrequencyTwo: Double) {
        ringModulator.frequency1 = ringFrequencyOne
        ringModulator.frequency2 = ringFrequencyTwo
    }

    func setDistortionParameters(distortionDecimation: Double, distortionRouding: Double) {
        distortion.decimation = distortionDecimation
        distortion.rounding = distortionRouding
        distortion.ringModMix = 0
        distortion.ringModBalance = 0
    }
}
