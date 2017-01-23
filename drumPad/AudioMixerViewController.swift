//
//  AudioMixerViewController.swift
//  drumPad
//
//  Created by Olaf Kroon on 13/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import UIKit

class AudioMixerViewController: UIViewController {
    

    // CLASSES DUS BEGINNEN MET HOOFDLETTER
    var snareKnob: Knob!
    var hatKnob: Knob!
    var kickKnob: Knob!
    var tomKnob: Knob!
    let ledController = ShowMixerLed()
    let enabledColor = UIColor(red: (246/255.0), green: (124/255.0), blue: (113/255.0), alpha: 1.0)
    
    
    @IBOutlet weak var snareLed: UILabel!
    @IBOutlet weak var kickLed: UILabel!
    @IBOutlet weak var hatLed: UILabel!
    @IBOutlet weak var tomLed: UILabel!
    @IBOutlet weak var hatKnobPlaceholder: UIView!
    @IBOutlet weak var tomKnobPlaceholder: UIView!
    @IBOutlet weak var snareKnobPlaceholder: UIView!
    @IBOutlet weak var kickKnobPlaceholder: UIView!
    @IBOutlet weak var enterMixSettings: UIButton!
    
    @IBOutlet weak var hatMixer: UISlider! {
        didSet{
            hatMixer.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        }
    }

    @IBOutlet weak var tomMixer: UISlider!{
        didSet{
            tomMixer.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        }
    }
    @IBOutlet weak var snareMixer: UISlider! {
        didSet{
            snareMixer.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        }
    }
    @IBOutlet weak var kickMixer: UISlider!{
        didSet{
            kickMixer.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kickMixer.value = Float(AudioController.sharedInstance.kickPlayer.volume)
        snareMixer.value = Float(AudioController.sharedInstance.snarePlayer.volume)
        tomMixer.value = Float(AudioController.sharedInstance.tomPlayer.volume)
        hatMixer.value = Float(AudioController.sharedInstance.hatPlayer.volume)
        
        snareKnob = Knob(frame: snareKnobPlaceholder.bounds)
        snareKnobPlaceholder.addSubview(snareKnob)
        snareKnob.value = Float(AudioController.sharedInstance.snarePlayer.pan)
        
        kickKnob = Knob(frame: kickKnobPlaceholder.bounds)
        kickKnobPlaceholder.addSubview(kickKnob)
        kickKnob.value = Float(AudioController.sharedInstance.kickPlayer.pan)
        kickKnobPlaceholder.isUserInteractionEnabled = true
        
        tomKnob = Knob(frame: tomKnobPlaceholder.bounds)
        tomKnobPlaceholder.addSubview(tomKnob)
        tomKnob.value = Float(AudioController.sharedInstance.tomPlayer.pan)
        
        hatKnob = Knob(frame: hatKnobPlaceholder.bounds)
        hatKnobPlaceholder.addSubview(hatKnob)
        hatKnob.value = Float(AudioController.sharedInstance.hatPlayer.pan)
        enterMixSettings.layer.cornerRadius = 5
        
        // PROGRAMATICALLY GESTURES
//        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.kickKnobPan))
//        kickKnobPlaceholder.addGestureRecognizer(pan)
        
        // Do any additional setup after loading the view.
    }
    
//    // This doesn't work either
//    func kickKnobPan(sender: UIPanGestureRecognizer) {
//        print("PAN")
//        if sender.state == cha
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func changeHatDb(_ sender: Any) {
        if hatMixer.isTracking {
            hatLed.text = ledController.calculateLevel(currentLevel: hatMixer.value)
        } else {
            hatLed.text = "Hat"
        }
    }
    @IBAction func changeTomDb(_ sender: Any) {
        if tomMixer.isTracking {
            tomLed.text = ledController.calculateLevel(currentLevel: tomMixer.value)
        } else {
            tomLed.text = "Tom"
        }
    }
    @IBAction func changeSnareDb(_ sender: Any) {
        if snareMixer.isTracking {
            snareLed.text = ledController.calculateLevel(currentLevel: snareMixer.value)
        } else {
            snareLed.text = "Snare"
        }
    }
    @IBAction func changeKickDb(_ sender: Any) {
        if kickMixer.isTracking {
            kickLed.text = ledController.calculateLevel(currentLevel: kickMixer.value)
        } else {
            kickLed.text = "Kick"
        }
    }
    
    
    
    @IBAction func setMixSettings(_ sender: Any) {
        enterMixSettings.backgroundColor = enabledColor
        tomKnob.roundValue()
        kickKnob.roundValue()
        hatKnob.roundValue()
        snareKnob.roundValue()
        
        if enterMixSettings.isTouchInside{
            AudioController.sharedInstance.mixAudio(kickVolume: kickMixer.value, snareVolume: snareMixer.value, tomVolume: tomMixer.value, hatVolume: hatMixer.value, Kickpan: kickKnob.value, snarePan: snareKnob.value, tomPan: tomKnob.value, hatPan: hatKnob.value)
        }
    }
    
}
