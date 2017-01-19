//
//  ViewController.swift
//  drumPad
//
//  Created by Olaf Kroon on 09/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import UIKit
import AudioKit


class ViewController: UIViewController {
    
    @IBOutlet weak var metronomeTempoSlider: UISlider!
    @IBOutlet weak var metronomeButton: UIButton!
    @IBOutlet weak var nextKit: UIButton!
    @IBOutlet weak var previousKit: UIButton!
    @IBOutlet weak var kitDisplay: UILabel!
    @IBOutlet weak var kickPad: UIButton!
    @IBOutlet weak var tomPad: UIButton!
    @IBOutlet weak var hiHatPad: UIButton!
    @IBOutlet weak var snarePad: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kitDisplay.text = AudioController.sharedInstance.LEDKitSelector.displayKit
        metronomeTempoSlider.value = Float(AudioController.sharedInstance.currentFrequency)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
               // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setNextDisplay(_ sender: Any) {
        if nextKit.isTouchInside {
            AudioController.sharedInstance.LEDKitSelector.displayNext()
            kitDisplay.text =  AudioController.sharedInstance.LEDKitSelector.displayKit
            AudioController.sharedInstance.replaceKit(kitName: kitDisplay.text!)
        }
    }
    
    @IBAction func setPreviousDisplay(_ sender: Any) {
        if previousKit.isTouchInside {
            AudioController.sharedInstance.LEDKitSelector.displayPrevious()
            kitDisplay.text = AudioController.sharedInstance.LEDKitSelector.displayKit
            AudioController.sharedInstance.replaceKit(kitName: kitDisplay.text!)
        }
    }
    
    @IBAction func enableMetronome(_ sender: Any) {
        if metronomeButton.isTouchInside {
            AudioController.sharedInstance.setMetronome()
        }
    }
    
    @IBAction func kickPadTouchDown(_ sender: UIButton) {
        AudioController.sharedInstance.playSample(player: &AudioController.sharedInstance.kickPlayer)
    }
    
    @IBAction func snarePadTouchDown(_ sender: UIButton) {
        AudioController.sharedInstance.playSample(player: &AudioController.sharedInstance.snarePlayer)
    }
    
    @IBAction func tomPadTouchDown(_ sender: UIButton) {
        AudioController.sharedInstance.playSample(player: &AudioController.sharedInstance.tomPlayer)
    }
    
    @IBAction func hatPadTouchDown(_ sender: UIButton) {
        AudioController.sharedInstance.playSample(player: &AudioController.sharedInstance.hatPlayer)
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

