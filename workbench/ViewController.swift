//
//  ViewController.swift
//  workbench
//
//  Created by admin on 4/08/2016.
//  Copyright © 2016 stethee.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ttttt: STTextFiled!
    var hdn = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didtap(sender: AnyObject) {
        ttttt.ErrorLabel.hidden=hdn
        hdn = !hdn
    }

}

