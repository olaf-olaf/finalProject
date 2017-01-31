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
    
    var frequencyAKnob: Knob!
    var frequencyBKnob: Knob!

    @IBOutlet weak var frequencyBPKnoblaceholder: UIView!
    @IBOutlet weak var frequencyAKnobPlaceholder: UIView!
    @IBOutlet weak var setRingButton: UIButton!
    
    let enabledColor = UIColor(red: (246/255.0), green: (124/255.0), blue: (113/255.0), alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        setRingButton.layer.cornerRadius = 5
        
        frequencyAKnob = Knob(frame: frequencyAKnobPlaceholder.bounds)
        frequencyAKnobPlaceholder.addSubview(frequencyAKnob)
        frequencyAKnob.setKnobDisplay(largeButton: true, minimum: 0, maximum: 800)
        frequencyAKnob.value = Float(AudioController.sharedInstance.ringModulator.frequency1)
        
        frequencyBKnob = Knob(frame: frequencyBPKnoblaceholder.bounds)
        frequencyBPKnoblaceholder.addSubview(frequencyBKnob)
        frequencyBKnob.setKnobDisplay(largeButton: true, minimum: 0, maximum: 800)
        frequencyBKnob.value = Float(AudioController.sharedInstance.ringModulator.frequency2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func setRingParameters(_ sender: UIButton) {
        setRingButton.backgroundColor = enabledColor
        let frequencyA = Double(frequencyAKnob.value)
        let frequencyB = Double(frequencyBKnob.value)
        AudioController.sharedInstance.setRingParameters(ringFrequencyOne: frequencyA, ringFrequencyTwo: frequencyB)
    }
}
