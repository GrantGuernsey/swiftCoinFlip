//
//  ViewController.swift
//  coinFlip
//
//  Created by Guernsey Grant on 11/12/19.
//  Copyright © 2019 stx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var coinImage: UIImageView!
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var weightText: UITextField!
    
    @IBOutlet weak var historyLabel: UILabel!
    
    @IBOutlet weak var flipNumberSlider: UISlider!
    
    @IBOutlet weak var flipNuberLabel: UILabel!
    
    @IBOutlet weak var working: UILabel!
    
    @IBAction func valueChanged(_ sender: UISlider) {
        flipNuberLabel.text = String(Int(flipNumberSlider.value))
    }
    
    var largeFlip:[String] = []
    
    @IBAction func sliderTouchUp(_ sender: UISlider) {
        var count = 0
        let number = Int(flipNumberSlider.value)
        
        while count < number
        {
            largeFlip.append(flipCoin(weight: 50))
            count += 1
        }
        
        var heads = 0
        var tails = 0
        
        for value in largeFlip
        {
            if value == "T"
            {
                tails += 1
            }
            else
            {
                heads += 1
            }
        }
        
        working.text = "Out of the \(number) flips, \(heads) were heads and \(tails) were tails"
        
        largeFlip.removeAll()
    }
    
    var flipsList:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake
        {
            //do stuff!
            let randomNum = Int.random(in: 1...100)
            if randomNum < 5
            {
                flipsList.append("S")
                coinImage.image = UIImage(named: "side")
                changeBackgroundColor()
                
            }
            else
            {
                flipsList.append(flipCoin(weight: 50))
            }
            upadteHistoryLabel()
        }
    }
    
    func changeBackgroundColor()
    {
        if mainView.backgroundColor == UIColor.red
        {
            mainView.backgroundColor = UIColor.brown
        }
        else
        {
           mainView.backgroundColor = UIColor.red
        }
        
    }
    
    
    
    func flipCoin(weight: Int)->String
    {
        changeBackgroundColor()
        let flip = Int.random(in: 0..<100)
        if flip < weight
        {
            coinImage.image = UIImage(named: "heads")
            return "H"
        }
        else
        {
            coinImage.image = UIImage(named: "tails")
            return "T"
        }
    }
    
    
    
    @IBAction func biasedButtonPressed(_ sender: UIButton) {
        flipsList.append(flipCoin(weight: 67))
        upadteHistoryLabel()
    }
    
    @IBAction func weightedFlip(_ sender: UIButton)
    {
        let biasedWeight = Int(weightText.text ?? "50") ?? 50
        flipsList.append(flipCoin(weight: biasedWeight))
        upadteHistoryLabel()
    }
    
    func upadteHistoryLabel()
    {
        var newLabel = ""
        var count = flipsList.count
        var runningCount = 0
        while count > 0 {
            if runningCount < 5
            {
                newLabel += flipsList[count-1]
            }
            count = count - 1
            runningCount += 1
        }
        historyLabel.text = newLabel
    }
    
    
    @IBAction func resetButton(_ sender: UIButton) {
        flipsList.removeAll()
        upadteHistoryLabel()
    }
    
    
    
    
    
}

