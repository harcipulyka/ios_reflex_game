//
//  Variables.swift
//  firstAttempt
//
//  Created by Rácz Balázs on 2020. 03. 11..
//  Copyright © 2020. Rácz Balázs. All rights reserved.
//

import AVFoundation
import UIKit

struct Var {
    var player : AVAudioPlayer?
    
    var rightColor : UIColor?
    var rightButtonText : UILabel?
    var score : Int = 0
    var round : Int = 0
    let maxRound : Int = 25
    var isFirstClick : Bool = true
    var mistakes : Int = 0
    var prevBad : Int = 1
    var start : CFAbsoluteTime?
    var end : CFAbsoluteTime?
    var endResul : Float = 0.0
    
    mutating func playSound(_ soundName: String) {
        let path = Bundle.main.path(forResource: soundName, ofType:"wav")!
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            // couldn't load file :(
            print("wrong file")
        }
    }
    
    func randomRGB () -> (UIColor){
        
        let red : CGFloat = CGFloat.random(in: 0...1)
        let green : CGFloat = CGFloat.random(in: 0...1)
        let blue : CGFloat = CGFloat.random(in: 0...1)
        
        let color = UIColor(red: red, green: green, blue : blue, alpha: 1)
        
        return color
    }
}
