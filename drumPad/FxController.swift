//
//  FxController.swift
//  drumPad
//
//  Created by Olaf Kroon on 11/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import UIKit

class FxController: UIViewController {
    
    @IBOutlet weak var enterFx: UIButton!
    
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
        ringSlider.value = Float(AudioController.sharedInstance.FxMixControls.ringMix)
        reverbSlider.value = Float(AudioController.sharedInstance.FxMixControls.reverbMix)
        distortionSlider.value = Float(AudioController.sharedInstance.FxMixControls.distortionMix)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setFx(_ sender: Any) {
        if enterFx.isTouchInside {
            AudioController.sharedInstance.setReverbDryWet(level: reverbSlider.value)
            AudioController.sharedInstance.setDistortionDryWet(level: distortionSlider.value)
            AudioController.sharedInstance.setRingModulaterDryWet(level: ringSlider.value)
        }
    }
}
