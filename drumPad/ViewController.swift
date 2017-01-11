//
//  ViewController.swift
//  drumPad
//
//  Created by Olaf Kroon on 09/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import UIKit
import AudioKit
import AVFoundation

class ViewController: UIViewController {
    
    var hiHat: AVAudioPlayer!
    
    
    
    @IBOutlet weak var kickPad: UIButton!
    @IBOutlet weak var tomPad: UIButton!
    @IBOutlet weak var hiHatPad: UIButton!
    @IBOutlet weak var snarePad: UIButton!
    
    let Kick = DrumPadClass()
    //var player = AKAudioPlayer.self
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let mixloop = try! AKAudioFile(readFileName: "808Kick.wav")
//        let player = try! AKAudioPlayer(file: mixloop)
//        player.looping = true
//        AudioKit.output = player
//        AudioKit.start()
//        player.play()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func kickPadPressed(_ sender: Any) {
        if kickPad.isTouchInside{
            AudioKit.stop()
            print ("KICK!")
            let mixloop = try! AKAudioFile(readFileName: "808Kick.wav")
            let player = try! AKAudioPlayer(file: mixloop)
            AudioKit.output = player
            AudioKit.start()
            player.play()
            
    
            
//            AudioKit.output = Kick.play(fileName: "808Kick.wav")
            //AudioKit.start()
        }
    }
    
    @IBAction func tomPadPressed(_ sender: Any) {
        if tomPad.isTouchInside{
            print ("TOM!")
        }
    }
    
    @IBAction func snarePadPressed(_ sender: Any) {
        if snarePad.isTouchInside{
            print ("SNARE!")
            AudioKit.stop()
            let mixloop = try! AKAudioFile(readFileName: "808Snare.wav")
            let player = try! AKAudioPlayer(file: mixloop)
            AudioKit.output = player
            AudioKit.start()
            player.play()
        }
    }
    
    @IBAction func hiHatPadPressed(_ sender: Any) {
        if hiHatPad.isTouchInside{
            print ("HIHAT!")
            let path = Bundle.main.path(forResource: "808HiHat", ofType: "wav")!
            let url = URL(fileURLWithPath: path)
            
            do {
                let sound = try AVAudioPlayer(contentsOf: url)
                hiHat = sound
                sound.play()
            } catch {
                print ("LOADING FAILED")
            }

        }
    }
}

