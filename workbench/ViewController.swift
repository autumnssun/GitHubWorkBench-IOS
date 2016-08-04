//
//  ViewController.swift
//  workbench
//
//  Created by admin on 4/08/2016.
//  Copyright © 2016 stethee.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var ttttt: STS_Textfiled_Simple!
    @IBOutlet var bbb: STS_Textfiled_Simple!
    @IBOutlet var NoError: STS_Textfiled_Simple!
    
    var hdn = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didtap(sender: AnyObject) {
        hdn = !hdn
        ttttt.ErrorString="problem"
        bbb.ErrorString = "sdfdf"
        if(hdn){
            self.bbb.showError()
            self.ttttt.showError()
            self.NoError.showError()
        }else{
            self.bbb.hideError()
            self.ttttt.hideError()
            self.NoError.hideError()
            
        }
    }
    
}

