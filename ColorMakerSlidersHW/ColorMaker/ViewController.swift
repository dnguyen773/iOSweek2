//
//  ViewController.swift
//  ColorSliderHW
//
//  Created by Danny Nguyen on 7/5/16.
//  Copyright © 2016 Danny Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeColor(sender: AnyObject){
        let r: CGFloat = CGFloat(self.redSlider.value)
        let b: CGFloat = CGFloat(self.blueSlider.value)
        let g: CGFloat = CGFloat(self.greenSlider.value)
        
        colorView.backgroundColor = UIColor(red: r, green: g,blue: b, alpha: 1)
        
    }
    
    
}

