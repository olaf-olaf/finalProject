//
//  DelayParameterViewController.swift
//  drumPad
//
//  Created by Olaf Kroon on 25/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import UIKit

class DelayParameterViewController: UIViewController {
    
    var TimeKnob: Knob!
    var FeedbackKnob: Knob!
   
    @IBOutlet weak var setDelayButton: UIButton!
    let enabledColor = UIColor(red: (246/255.0), green: (124/255.0), blue: (113/255.0), alpha: 1.0)
    
    @IBOutlet weak var feedbackKnobPlaceholder: UIView!
    @IBOutlet weak var timeKnobPlaceholder: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelayButton.layer.cornerRadius = 5
        
        FeedbackKnob = Knob(frame: feedbackKnobPlaceholder.bounds)
        feedbackKnobPlaceholder.addSubview(FeedbackKnob)
        FeedbackKnob.lineWidth = 5.0
        FeedbackKnob.pointerLength = 10.0
        FeedbackKnob.minimumValue = 0
        FeedbackKnob.maximumValue = 1
        
        FeedbackKnob.value = Float(AudioController.sharedInstance.delay.feedback)
        TimeKnob = Knob(frame: timeKnobPlaceholder.bounds)
        timeKnobPlaceholder.addSubview(TimeKnob)
        TimeKnob.lineWidth = 5.0
        TimeKnob.pointerLength = 10.0
        TimeKnob.minimumValue = 0
        TimeKnob.maximumValue = 1
        TimeKnob.value = Float(AudioController.sharedInstance.delay.time)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func setDelay(_ sender: UIButton) {
        setDelayButton.backgroundColor = enabledColor
        let time = Double(TimeKnob.value)
        let feedback = Double(FeedbackKnob.value)
        AudioController.sharedInstance.setDelayParameters(delayTime: time, delayFeedback: feedback)
    }
}
