//
//  AudioMixerViewController.swift
//  drumPad
//
//  Created by Olaf Kroon on 13/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import UIKit

class AudioMixerViewController: UIViewController {
    
    @IBOutlet weak var enterMixSettings: UIButton!
    @IBOutlet weak var hatMixer: UISlider! {
        didSet{
            hatMixer.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        }
    }

    @IBOutlet weak var tomMixer: UISlider!{
        didSet{
            tomMixer.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        }
    }
    @IBOutlet weak var snareMixer: UISlider! {
        didSet{
            snareMixer.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        }
    }
    @IBOutlet weak var kickMixer: UISlider!{
        didSet{
            kickMixer.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        kickMixer.value = Float(AudioController.sharedInstance.kickPlayer.volume)
        snareMixer.value = Float(AudioController.sharedInstance.snarePlayer.volume)
        tomMixer.value = Float(AudioController.sharedInstance.tomPlayer.volume)
        hatMixer.value = Float(AudioController.sharedInstance.hatPlayer.volume)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setMixSettings(_ sender: Any) {
        if enterMixSettings.isTouchInside{
            AudioController.sharedInstance.mixAudio(kickVolume: kickMixer.value, snareVolume: snareMixer.value, tomVolume: tomMixer.value, hatVolume: hatMixer.value, Kickpan: 0.0, snarePan: 0.0 , tomPan: 0.0, hatPan: 0.0)
        }
    }

}
