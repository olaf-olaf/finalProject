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
        
        AudioController.sharedInstance
        kitDisplay.text = ShowKitLed.sharedInstance.displayKit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func kickPadPressed(_ sender: Any) {
        if kickPad.isTouchInside{
            AudioController.sharedInstance.kickPlayer.play()
        }
    }
    
    @IBAction func tomPadPressed(_ sender: Any) {
        if tomPad.isTouchInside{
            AudioController.sharedInstance.tomPlayer.play()
        }
    }
   
    @IBAction func snarePadPressed(_ sender: Any) {
        if snarePad.isTouchInside{
            AudioController.sharedInstance.snarePlayer.play()
        }
    }
    
    @IBAction func hiHatPadPressed(_ sender: Any) {
        if hiHatPad.isTouchInside{
            AudioController.sharedInstance.hatPlayer.play()
        }
    }
}

