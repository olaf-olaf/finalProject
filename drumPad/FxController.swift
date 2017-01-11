//
//  FxController.swift
//  drumPad
//
//  Created by Olaf Kroon on 11/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//

import UIKit

class FxController: UIViewController {

    @IBOutlet weak var delaySlider: UISlider!{
        didSet{
            delaySlider.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        }
    }
    @IBOutlet weak var distortionSlider: UISlider!{
        didSet{
            distortionSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        }
    }

    @IBOutlet weak var reverbSlider: UISlider!{
    didSet{
        reverbSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
