//
//  ViewController.swift
//  drumPad
//
//  Created by Olaf Kroon on 09/01/17.
//  Student number: 10787321
//  Course: Programmeerproject
//
//  ViewController contains the main view of the application. It consists of a slider, 
//  4 buttons representing a drumpads, a metronome button, an FX button, a mixer buttons, 
//  ands two buttons that can be used to scroll through different kits.
//
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Variables.
    let enabledColor = UIColor(red: (246/255.0), green: (124/255.0), blue: (113/255.0), alpha: 1.0)
    let disabledColor = UIColor(red: (245/255.0), green: (245/255.0), blue: (245/255.0), alpha: 1.0)
    let idlePadColor = UIColor(red: (102/255.0), green: (102/255.0), blue: (102/255.0), alpha: 1.0)
    
    // MARK: - Outlets.
    @IBOutlet weak var mixerButton: UIButton!
    @IBOutlet weak var fxButton: UIButton!
    @IBOutlet weak var metronomeTempoSlider: UISlider!
    @IBOutlet weak var metronomeButton: UIButton!
    @IBOutlet weak var nextKit: UIButton!
    @IBOutlet weak var previousKit: UIButton!
    @IBOutlet weak var kitDisplay: UILabel!
    @IBOutlet weak var kickPad: UIButton!
    @IBOutlet weak var tomPad: UIButton!
    @IBOutlet weak var hiHatPad: UIButton!
    @IBOutlet weak var snarePad: UIButton!
    
    // MARK: - UIViewController lifecycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        kitDisplay.text = AudioController.sharedInstance.LEDKitSelector.displayKit
        kitDisplay.textAlignment = .center
        metronomeTempoSlider.value = Float(AudioController.sharedInstance.currentFrequency)
        
        nextKit.layer.cornerRadius = 5
        previousKit.layer.cornerRadius = 5
        metronomeButton.layer.cornerRadius = 5
        mixerButton.layer.cornerRadius = 5
        fxButton.layer.cornerRadius = 5
        
        if AudioController.sharedInstance.generator.isPlaying {
            metronomeButton.backgroundColor = enabledColor
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Actions.
    @IBAction func touchDownMixer(_ sender: UIButton) {
        mixerButton.backgroundColor = enabledColor
    }
    
    @IBAction func downFxbutton(_ sender: UIButton) {
        fxButton.backgroundColor = enabledColor
    }
    
    @IBAction func touchDownNext(_ sender: UIButton) {
        
        nextKit.backgroundColor = enabledColor
    }
    
    @IBAction func setNextDisplay(_ sender: Any) {
        if nextKit.isTouchInside {
            AudioController.sharedInstance.LEDKitSelector.displayNext()
            kitDisplay.text =  AudioController.sharedInstance.LEDKitSelector.displayKit
            AudioController.sharedInstance.replaceKit(kitName: kitDisplay.text!)
            nextKit.backgroundColor = disabledColor
        }
    }
    
    @IBAction func touchDownPrevious(_ sender: UIButton) {
        previousKit.backgroundColor = enabledColor
    }
    
    @IBAction func setPreviousDisplay(_ sender: Any) {
        if previousKit.isTouchInside {
            AudioController.sharedInstance.LEDKitSelector.displayPrevious()
            kitDisplay.text = AudioController.sharedInstance.LEDKitSelector.displayKit
            AudioController.sharedInstance.replaceKit(kitName: kitDisplay.text!)
            previousKit.backgroundColor = disabledColor
        }
    }
    
    @IBAction func enableMetronome(_ sender: Any) {
        if metronomeButton.isTouchInside {
            AudioController.sharedInstance.setMetronome()
            if AudioController.sharedInstance.generator.isPlaying {
                metronomeButton.backgroundColor = enabledColor
            } else {
                 metronomeButton.backgroundColor = disabledColor
            }
        }
    }
    
    @IBAction func kickPadTouchDown(_ sender: UIButton) {
        AudioController.sharedInstance.playSample(player: AudioController.sharedInstance.kickPlayer, backupPlayer: AudioController.sharedInstance.backupKickPlayer)
        kickPad.backgroundColor = enabledColor
    }
    
    @IBAction func releaseKickPad(_ sender: Any) {
        if kickPad.isTouchInside {
             kickPad.backgroundColor = idlePadColor        }
    }
    
    @IBAction func snarePadTouchDown(_ sender: UIButton) {
        AudioController.sharedInstance.playSample(player: AudioController.sharedInstance.snarePlayer, backupPlayer: AudioController.sharedInstance.backupSnarePlayer)
        snarePad.backgroundColor = enabledColor
    }
    
    @IBAction func releaseSnarePad(_ sender: Any) {
        if snarePad.isTouchInside {
            snarePad.backgroundColor = idlePadColor
        }
    }
  
    @IBAction func tomPadTouchDown(_ sender: UIButton) {
        AudioController.sharedInstance.playSample(player: AudioController.sharedInstance.tomPlayer, backupPlayer: AudioController.sharedInstance.backupTomPlayer)
        tomPad.backgroundColor = enabledColor
    }
    
    @IBAction func releaseTomPad(_ sender: Any) {
        if tomPad.isTouchInside {
            tomPad.backgroundColor = idlePadColor
        }
    }
    
    @IBAction func hatPadTouchDown(_ sender: UIButton) {
        AudioController.sharedInstance.playSample(player: AudioController.sharedInstance.hatPlayer, backupPlayer: AudioController.sharedInstance.backupHatPlayer)
        hiHatPad.backgroundColor = enabledColor
    }
    
    @IBAction func releaseHatPad(_ sender: Any) {
        if hiHatPad.isTouchInside{
            hiHatPad.backgroundColor = idlePadColor
        }
    }
    
    @IBAction func setMetronomeTempo(_ sender: UISlider) {
        AudioController.sharedInstance.setMetronomeTempo(bpm: metronomeTempoSlider.value)
        if metronomeTempoSlider.isTracking {
            let bpm = String(format: "%.0f", metronomeTempoSlider.value)
            kitDisplay.text = ("bpm: " + bpm)
        } else {
             kitDisplay.text = AudioController.sharedInstance.LEDKitSelector.displayKit
        }
    }

    @IBAction func releasedTempoSlider(_ sender: UISlider) {
        kitDisplay.text = AudioController.sharedInstance.LEDKitSelector.displayKit
    }
}

