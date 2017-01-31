//
//  DelayParameterViewController.swift
//  drumPad
//
//  Created by Olaf Kroon on 25/01/17.
//  Student number: 10787321
//  Course: Programmeerproject
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import UIKit

class DelayParameterViewController: UIViewController {
    var timeKnob: Knob!
    var feedbackKnob: Knob!
    
    let enabledColor = UIColor(red: (246/255.0), green: (124/255.0), blue: (113/255.0), alpha: 1.0)
    
    @IBOutlet weak var setDelayButton: UIButton!
    @IBOutlet weak var feedbackKnobPlaceholder: UIView!
    @IBOutlet weak var timeKnobPlaceholder: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelayButton.layer.cornerRadius = 5
        
        feedbackKnob = Knob(frame: feedbackKnobPlaceholder.bounds)
        feedbackKnobPlaceholder.addSubview(feedbackKnob)
        feedbackKnob.setKnobDisplay(largeButton: true, minimum: 0, maximum: 1)
        feedbackKnob.value = Float(AudioController.sharedInstance.delay.feedback)
        
        timeKnob = Knob(frame: timeKnobPlaceholder.bounds)
        timeKnobPlaceholder.addSubview(timeKnob)
        timeKnob.setKnobDisplay(largeButton: true, minimum: 0, maximum: 1)
        timeKnob.value = Float(AudioController.sharedInstance.delay.time)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func setDelay(_ sender: UIButton) {
        setDelayButton.backgroundColor = enabledColor
        let time = Double(timeKnob.value)
        let feedback = Double(feedbackKnob.value)
        AudioController.sharedInstance.setDelayParameters(delayTime: time, delayFeedback: feedback)
    }
}
