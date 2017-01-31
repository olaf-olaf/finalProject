//
//  RingParameterViewController.swift
//  drumPad
//
//  Created by Olaf Kroon on 25/01/17.
//  Student number: 10787321
//  Course: Programmeerproject
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import UIKit

class RingParameterViewController: UIViewController {
    
    var FrequencyAKnob: Knob!
    var FrequencyBKnob: Knob!

    @IBOutlet weak var frequencyBPKnoblaceholder: UIView!
    @IBOutlet weak var frequencyAKnobPlaceholder: UIView!
    @IBOutlet weak var setRingButton: UIButton!
    
    let enabledColor = UIColor(red: (246/255.0), green: (124/255.0), blue: (113/255.0), alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        setRingButton.layer.cornerRadius = 5
        
        FrequencyAKnob = Knob(frame: frequencyAKnobPlaceholder.bounds)
        frequencyAKnobPlaceholder.addSubview(FrequencyAKnob)
        FrequencyAKnob.lineWidth = 5.0
        FrequencyAKnob.pointerLength = 10.0
        FrequencyAKnob.minimumValue = 0
        FrequencyAKnob.maximumValue = 800
        FrequencyAKnob.value = Float(AudioController.sharedInstance.ringModulator.frequency1)
        
        FrequencyBKnob = Knob(frame: frequencyBPKnoblaceholder.bounds)
        frequencyBPKnoblaceholder.addSubview(FrequencyBKnob)
        FrequencyBKnob.lineWidth = 5.0
        FrequencyBKnob.pointerLength = 10.0
        FrequencyBKnob.minimumValue = 0
        FrequencyBKnob.maximumValue = 800
        FrequencyBKnob.value = Float(AudioController.sharedInstance.ringModulator.frequency2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func setRingParameters(_ sender: UIButton) {
        setRingButton.backgroundColor = enabledColor
        let frequencyA = Double(FrequencyAKnob.value)
        let frequencyB = Double(FrequencyBKnob.value)
        AudioController.sharedInstance.setRingParameters(ringFrequencyOne: frequencyA, ringFrequencyTwo: frequencyB)
    }
}
