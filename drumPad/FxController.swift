//
//  FxController.swift
//  drumPad
//
//  Created by Olaf Kroon on 11/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import UIKit

class FxController: UIViewController {
    let enabledColor = UIColor(red: (246/255.0), green: (124/255.0), blue: (113/255.0), alpha: 1.0)
    
    @IBOutlet weak var setRing: UIButton!
    @IBOutlet weak var setDelay: UIButton!
    @IBOutlet weak var setDistortion: UIButton!
    @IBOutlet weak var setReverb: UIButton!
    @IBOutlet weak var enterFx: UIButton!
    @IBOutlet weak var delaySlider: UISlider!{
        didSet{
            delaySlider.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        }
    }

    @IBOutlet weak var ringSlider: UISlider!{
        didSet{
            ringSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        }
    }

    @IBOutlet weak var distortionSlider: UISlider!{
        didSet{
            distortionSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        }
    }

    @IBOutlet weak var reverbSlider: UISlider!{
    didSet{
        reverbSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ringSlider.value = Float(AudioController.sharedInstance.ringModulator.mix)
        reverbSlider.value = Float(AudioController.sharedInstance.reverb.dryWetMix)
        distortionSlider.value = Float(AudioController.sharedInstance.distortion.finalMix)
        delaySlider.value = Float(AudioController.sharedInstance.delay.dryWetMix)
        
        enterFx.layer.cornerRadius = 5
        setRing.layer.cornerRadius = 5
        setDelay.layer.cornerRadius = 5
        setDistortion.layer.cornerRadius = 5
        setReverb.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func ringPressed(_ sender: UIButton) {
        setRing.backgroundColor = enabledColor
    }
    @IBAction func delayPressed(_ sender: UIButton) {
        setDelay.backgroundColor = enabledColor
    }
    @IBAction func distortionPressed(_ sender: UIButton) {
        setDistortion.backgroundColor = enabledColor
    }
    @IBAction func reverbPressed(_ sender: UIButton) {
        setReverb.backgroundColor = enabledColor
    }
    @IBAction func setFx(_ sender: Any) {
        if enterFx.isTouchInside {
            enterFx.backgroundColor = enabledColor
            AudioController.sharedInstance.mixFx(reverbLevel: reverbSlider.value , distortionLevel: distortionSlider.value, ringLevel: ringSlider.value, delayLevel: delaySlider.value)
        }
    }
}
