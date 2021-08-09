//
//  ViewController.swift
//  firstAttempt
//
//  Created by Rácz Balázs on 2020. 03. 08..
//  Copyright © 2020. Rácz Balázs. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var topLeft: UIButton!
    @IBOutlet weak var topRight: UIButton!
    @IBOutlet weak var bottomRight: UIButton!
    @IBOutlet weak var bottomLeft: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var modeSwitch: UIButton!
    
    var values = Var()
    var player : AVAudioPlayer?
    var twoTone : Bool = false
    var stopper = Clock()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeColor()
        restartButton.layer.cornerRadius = 6
        modeSwitch.layer.cornerRadius = 6
        topRight.layer.cornerRadius = 6
        topLeft.layer.cornerRadius = 6
        bottomLeft.layer.cornerRadius = 6
        bottomRight.layer.cornerRadius = 6
//        restartButton.layer.borderColor = UIColor.white.cgColor
//        modeSwitch.layer.borderColor = UIColor.white.cgColor
//        restartButton.layer.borderWidth = 1
//        modeSwitch.layer.borderWidth = 1
    }
    
    func changeColor() {
        if !twoTone{
            changeColors1()
        } else {
            changeColors2()
        }
    }
    
    func changeColors1 () -> (){
        
        var buttons : [UIButton] = [topLeft, topRight, bottomLeft, bottomRight]
        let colors : [UIColor] = [#colorLiteral(red: 0.337254902, green: 0.3019607843, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.3019607843, blue: 0.3215686275, alpha: 1), #colorLiteral(red: 1, green: 0.8039215686, blue: 0.1215686275, alpha: 1), #colorLiteral(red: 0.3607843137, green: 1, blue: 0.5294117647, alpha: 1)]
        
        buttons.shuffle()
        
        let rnd : Int = Int.random(in: 0...3)
        
        values.rightColor = colors[rnd]
        backgroundView.backgroundColor = colors[rnd]
        values.rightButtonText = buttons[rnd].titleLabel
        
        for i in 0...3{
            buttons[i].backgroundColor = colors[i]
        }
        
        values.round += 1
    }
    
    func changeColors2 () -> (){
        
        let rightColor = #colorLiteral(red: 0.1137254902, green: 0.6588235294, blue: 0.7215686275, alpha: 1)
        let wrongColor = #colorLiteral(red: 0.9803921569, green: 0.5882352941, blue: 0.2549019608, alpha: 1)
        
        values.rightColor = rightColor
        backgroundView.backgroundColor = wrongColor
        
        var ibs = [topRight, topLeft, bottomLeft, bottomRight]
        var rnd : Int = values.prevBad
        while rnd == values.prevBad {
            rnd = Int.random(in: 0...3)
        }
        values.prevBad = rnd
        ibs[rnd]?.backgroundColor = rightColor
        values.rightButtonText = ibs[rnd]?.titleLabel
        ibs.remove(at: rnd)
        
        for v in ibs{
            v?.backgroundColor = wrongColor
        }
        
        values.round += 1
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        //print(sender.titleLabel!)
        if sender.titleLabel! == values.rightButtonText{
            //stopper.starter() //nocsak
            goodClick()
        }else{
            badClick()
        }
        
    }
    
    @IBAction func restartButton(_ sender: UIButton) {
        endOfGame(true)
    }
    
    @IBAction func twoTone(_ sender: UIButton) {
        twoTone = !twoTone
        endOfGame(true)
    }
    
    func goodClick () -> () {
        
        if values.isFirstClick {
            values.isFirstClick = false
            values.start = CFAbsoluteTimeGetCurrent()
            changeColor()
            addScore()
        } else {
            changeColor()
            addScore()
            //stopper.ender() //nocsak
        }
        
    }
    
    func badClick () -> (){
        values.mistakes += 1
    }
    
    func endOfGame (_ disrupted : Bool = false) -> (){
        
        if !disrupted{
            
            let time : Float = Float(values.end! - values.start!) + Float(values.mistakes)
            values.endResul = time
            print(time)
            print("At the endOfGame the score was \(values.score) and the round was \(values.round)")
            
            self.performSegue(withIdentifier: "goToResult", sender: self)

        }
        
        values.isFirstClick = true
        values.score = 0
        values.round = 0
        values.mistakes = 0
        changeColor()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.result = values.endResul
        }
    }
    
    func addScore() -> (){
        if values.score == 25{
            values.end = CFAbsoluteTimeGetCurrent()
            endOfGame()
        } else {
            values.score += 1
        }
    }
}

