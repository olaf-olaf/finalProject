//
//  distortionParametersViewController.swift
//  drumPad
//
//  Created by Olaf Kroon on 25/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import UIKit

class distortionParametersViewController: UIViewController {
    let enabledColor = UIColor(red: (246/255.0), green: (124/255.0), blue: (113/255.0), alpha: 1.0)
    
    var DecimationKnob: Knob!
    var RoundingKnob: Knob!
    
    @IBOutlet weak var setDistortion: UIButton!
    @IBOutlet weak var roundingKnobPlaceholder: UIView!
    @IBOutlet weak var decimationKnobPlaceholder: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDistortion.layer.cornerRadius = 5
        
        DecimationKnob = Knob(frame: decimationKnobPlaceholder.bounds)
        decimationKnobPlaceholder.addSubview(DecimationKnob)
        DecimationKnob.lineWidth = 5.0
        DecimationKnob.pointerLength = 10.0
        DecimationKnob.minimumValue = 0
        DecimationKnob.maximumValue = 1
        DecimationKnob.value = Float(AudioController.sharedInstance.distortion.decimation)
        
        RoundingKnob = Knob(frame: roundingKnobPlaceholder.bounds)
        roundingKnobPlaceholder.addSubview(RoundingKnob)
        RoundingKnob.lineWidth = 5.0
        RoundingKnob.pointerLength = 10.0
        RoundingKnob.minimumValue = 0
        RoundingKnob.maximumValue = 1
        RoundingKnob.value = Float(AudioController.sharedInstance.distortion.rounding)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func setDistortionParameters(_ sender: UIButton) {
        setDistortion.backgroundColor = enabledColor
        let decimation = Double(DecimationKnob.value)
        let rounding = Double(RoundingKnob.value)
        AudioController.sharedInstance.setDistortionParameters(distortionDecimation: decimation, distortionRouding: rounding)
    }
}
