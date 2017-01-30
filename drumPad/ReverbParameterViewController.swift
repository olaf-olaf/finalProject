//
//  ReverbParameterViewController.swift
//  drumPad
//
//  Created by Olaf Kroon on 24/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import UIKit

class ReverbParameterViewController: UIViewController {
    let enabledColor = UIColor(red: (246/255.0), green: (124/255.0), blue: (113/255.0), alpha: 1.0)
    
    var decayKnob: Knob!
    var delayKnob: Knob!
    var reflectionKnob: Knob!
    
    @IBOutlet weak var setReverbButton: UIButton!
    @IBOutlet weak var decayKnobPlaceHolder: UIView!
    @IBOutlet weak var delayKnobPlaceholder: UIView!
    @IBOutlet weak var reflectionKnobPlaceholder: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setReverbButton.layer.cornerRadius = 5
        
        // Voor dit initialisen misschien een method maken
        decayKnob = Knob(frame: decayKnobPlaceHolder.bounds)
        decayKnobPlaceHolder.addSubview(decayKnob)
        decayKnob.lineWidth = 5.0
        decayKnob.pointerLength = 10.0
        decayKnob.minimumValue = 0
        decayKnob.maximumValue = 2
        decayKnob.value = Float(AudioController.sharedInstance.reverb.decayTimeAtNyquist)
        
        delayKnob = Knob(frame: delayKnobPlaceholder.bounds)
        delayKnobPlaceholder.addSubview(delayKnob)
        delayKnob.lineWidth = 5.0
        delayKnob.pointerLength = 10.0
        delayKnob.minimumValue = 0
        delayKnob.maximumValue = 1
        delayKnob.value = Float(AudioController.sharedInstance.reverb.maxDelayTime)
        
        reflectionKnob = Knob(frame: reflectionKnobPlaceholder.bounds)
        reflectionKnobPlaceholder.addSubview(reflectionKnob)
        reflectionKnob.lineWidth = 5.0
        reflectionKnob.pointerLength = 10.0
        reflectionKnob.minimumValue = 1
        reflectionKnob.maximumValue = 15
        reflectionKnob.value = Float(AudioController.sharedInstance.reverb.randomizeReflections)
    }
   
    @IBAction func setReverb(_ sender: Any) {
        if setReverbButton.isTouchInside {
            setReverbButton.backgroundColor = enabledColor
            AudioController.sharedInstance.setReverbParameters(randomInflections: Double(reflectionKnob.value), maxDelay: Double(delayKnob.value), Decay: Double(decayKnob.value))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
