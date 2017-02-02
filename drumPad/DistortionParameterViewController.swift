//
//  distortionParametersViewController.swift
//  drumPad
//
//  Created by Olaf Kroon on 25/01/17.
//  Student number: 10787321
//  Course: Programmeerproject
//
//  DistortionParametersViewController consists of rotary knobs that are used to determine the parameters
//  of the reverb object in AudioContoller.
//
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import UIKit

class distortionParametersViewController: UIViewController {
    
    // MARK: - Variables.
    let enabledColor = UIColor(red: (246/255.0), green: (124/255.0), blue: (113/255.0), alpha: 1.0)
    var decimationKnob: Knob!
    var roundingKnob: Knob!
    
    // MARK: - Outlets.
    @IBOutlet weak var setDistortion: UIButton!
    @IBOutlet weak var roundingKnobPlaceholder: UIView!
    @IBOutlet weak var decimationKnobPlaceholder: UIView!
    
    // MARK: - UIViewController lifecycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        setDistortion.layer.cornerRadius = 5
        
        decimationKnob = Knob(frame: decimationKnobPlaceholder.bounds)
        decimationKnobPlaceholder.addSubview(decimationKnob)
        decimationKnob.setKnobDisplay(largeButton: true, minimum: 0, maximum: 1)
        decimationKnob.value = Float(AudioController.sharedInstance.distortion.decimation)
        
        roundingKnob = Knob(frame: roundingKnobPlaceholder.bounds)
        roundingKnobPlaceholder.addSubview(roundingKnob)
        roundingKnob.setKnobDisplay(largeButton: true, minimum: 0, maximum: 1)
        roundingKnob.value = Float(AudioController.sharedInstance.distortion.rounding)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Actions.
    @IBAction func setDistortionParameters(_ sender: UIButton) {
        setDistortion.backgroundColor = enabledColor
        let decimation = Double(decimationKnob.value)
        let rounding = Double(roundingKnob.value)
        AudioController.sharedInstance.setDistortionParameters(distortionDecimation: decimation, distortionRouding: rounding)
    }
}
