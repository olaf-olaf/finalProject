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
    
    @IBOutlet weak var setReverbButton: UIButton!
    var DecayKnob: Knob!
    var DelayKnob: Knob!
    var ReflectionKnob: Knob!
    @IBOutlet weak var decayKnobPlaceHolder: UIView!
    @IBOutlet weak var delayKnobPlaceholder: UIView!
    @IBOutlet weak var reflectionKnobPlaceholder: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setReverbButton.layer.cornerRadius = 5
        
        DecayKnob = Knob(frame: decayKnobPlaceHolder.bounds)
        decayKnobPlaceHolder.addSubview(DecayKnob)
        DecayKnob.lineWidth = 5.0
        DecayKnob.pointerLength = 10.0
        DecayKnob.minimumValue = 0
        DecayKnob.maximumValue = 2
        DecayKnob.value = Float(AudioController.sharedInstance.reverb.decayTimeAtNyquist)
        
        
        DelayKnob = Knob(frame: delayKnobPlaceholder.bounds)
        delayKnobPlaceholder.addSubview(DelayKnob)
        DelayKnob.lineWidth = 5.0
        DelayKnob.pointerLength = 10.0
        DelayKnob.minimumValue = 0
        DelayKnob.maximumValue = 1
        DelayKnob.value = Float(AudioController.sharedInstance.reverb.maxDelayTime)
        
        ReflectionKnob = Knob(frame: reflectionKnobPlaceholder.bounds)
        reflectionKnobPlaceholder.addSubview(ReflectionKnob)
        ReflectionKnob.lineWidth = 5.0
        ReflectionKnob.pointerLength = 10.0
        ReflectionKnob.minimumValue = 1
        ReflectionKnob.maximumValue = 15
        ReflectionKnob.value = Float(AudioController.sharedInstance.reverb.randomizeReflections)
       
        

        // Do any additional setup after loading the view.
    }
   
    @IBAction func setReverb(_ sender: Any) {
        if setReverbButton.isTouchInside {
            
            setReverbButton.backgroundColor = enabledColor
            let minDelay = AudioController.sharedInstance.reverb.minDelayTime
            let decayOne = AudioController.sharedInstance.reverb.decayTimeAt0Hz
            AudioController.sharedInstance.setReverbParameters(randomInflections: Double(ReflectionKnob.value), minDelay: minDelay, maxDelay: Double(DelayKnob.value), decayOne: decayOne, DecayTwo: Double(DecayKnob.value))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
