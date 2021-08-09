//
//  ResultViewController.swift
//  firstAttempt
//
//  Created by Rácz Balázs on 2020. 03. 15..
//  Copyright © 2020. Rácz Balázs. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    
    @IBOutlet weak var resultLabel: UILabel!
    
    var result : Float = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = String(format: "%.3f", result)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func restartButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
