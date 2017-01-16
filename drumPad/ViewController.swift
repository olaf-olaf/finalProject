//
//  ViewController.swift
//  drumPad
//
//  Created by Olaf Kroon on 09/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
   
 
    
    @IBOutlet weak var nextKit: UIButton!
    @IBOutlet weak var previousKit: UIButton!
    @IBOutlet weak var kitDisplay: UILabel!
    @IBOutlet weak var kickPad: UIButton!
    @IBOutlet weak var tomPad: UIButton!
    @IBOutlet weak var hiHatPad: UIButton!
    @IBOutlet weak var snarePad: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Call the the sharedinstance so the first hit won't have latency issues.
        
        //AudioController.sharedInstance
        kitDisplay.text = ShowKitLed.sharedInstance.displayKit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
               // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setNextDisplay(_ sender: Any) {
        if nextKit.isTouchInside {
            ShowKitLed.sharedInstance.displayNext()
            kitDisplay.text = ShowKitLed.sharedInstance.displayKit
            AudioController.sharedInstance.replaceKit(kitName: kitDisplay.text!)
        }
    }
    
    @IBAction func setPreviousDisplay(_ sender: Any) {
        if previousKit.isTouchInside {
            ShowKitLed.sharedInstance.displayPrevious()
            kitDisplay.text = ShowKitLed.sharedInstance.displayKit
            AudioController.sharedInstance.replaceKit(kitName: kitDisplay.text!)
        }
    }
    
    @IBAction func kickPadTouchDown(_ sender: UIButton) {
        print ("KICK")
        AudioController.sharedInstance.kickPlayer.play()
    }
    
    @IBAction func snarePadTouchDown(_ sender: UIButton) {
        AudioController.sharedInstance.snarePlayer.play()
    }
    
    @IBAction func tomPadTouchDown(_ sender: UIButton) {
         AudioController.sharedInstance.tomPlayer.play()
    }
    
    @IBAction func hatPadTouchDown(_ sender: UIButton) {
        AudioController.sharedInstance.hatPlayer.play()
    }
}

