//
//  ViewController.swift
//  Tens
//
//  Created by Nick Chao on 2017-10-04.
//  Copyright © 2017 Nicholas Chao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //play button object
    @IBOutlet weak var playButton: UIButton!
    
    //these buttons correspond to the feed
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var buttonFive: UIButton!
    @IBOutlet weak var buttonSix: UIButton!
    @IBOutlet weak var buttonSeven: UIButton!
    @IBOutlet weak var buttonEight: UIButton!
    @IBOutlet weak var buttonNine: UIButton!
    //this is the score board
    @IBOutlet weak var scoreBoard: UITextField!
    //play button
    @IBOutlet weak var play: UIButton!
    //"you lose" text
    @IBOutlet weak var youLose: UITextField!
    //timer
    @IBOutlet weak var timerLabel: UILabel!
    var seconds = 15
    var timer = Timer()
    var isTimerRunning = false
    var timerStop = false
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        seconds -= 1
        timerLabel.text = "\(seconds)"
        if seconds == 0{
            playButton.isEnabled = true
            timer.invalidate()
            feed = []
            youLose.text = "You lose!"
        }
    }
    
    //this array will later be filled with 9 random numbers
    var feed = [Int]()
    //this array will later be filled with user input via buttons
    var userInput = [Int]()

    //this var is the score
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func playButton(_ sender: UIButton) {
        //pressing play will begin the game by giving you 9 random numbers to start. Also, resets score to zero and starts timer
        
        playButton.isEnabled = false
        
        seconds = 13
        
        timer.invalidate()
        
        //run timer
        runTimer()
        
        youLose.text = ""
        score = 0
        scoreBoard.text = String(score)
        
        //create our 9 random numbers and assign them to UI buttons
        var i = 0
        while i < 9 {
            feed.append(Int(arc4random_uniform(9) + 1))
            i+=1
        }
        buttonOne.setTitle(String(feed[0]), for: .normal)
        buttonTwo.setTitle(String(feed[1]), for: .normal)
        buttonThree.setTitle(String(feed[2]), for: .normal)
        buttonFour.setTitle(String(feed[3]), for: .normal)
        buttonFive.setTitle(String(feed[4]), for: .normal)
        buttonSix.setTitle(String(feed[5]), for: .normal)
        buttonSeven.setTitle(String(feed[6]), for: .normal)
        buttonEight.setTitle(String(feed[7]), for: .normal)
        buttonNine.setTitle(String(feed[8]), for: .normal)
    }
    
    //this function checks the user input for sum of 10
    func checkTen(array: [Int])->Bool{
        if array[0] + array[1] + array[2] == 10 || array[0] + array[1] - array[2] == 10{
            return true
        }
        else{
            return false
        }
    }
    
    //this function will take input of feed (the 9 random numbers) and userInput and take out
    //userInput from three. It then replaces userInput with 3 new random numbers
    func threeNew(arrayFeed: [Int], arrayInput: [Int])->[Int]{
        var arrayReturn = arrayFeed
        var z = 0
        while z < 3{
            var i = 0
            var j = 0
            while i < arrayReturn.count && j < 1{
                if arrayInput[z] == arrayReturn[i]{
                    arrayReturn.remove(at: i)
                    j+=1
                }
                i+=1
            }
            z+=1
        }
        arrayReturn += [Int(arc4random_uniform(9) + 1), Int(arc4random_uniform(9) + 1), Int(arc4random_uniform(9) + 1),]
        return arrayReturn
    }
    
    //following function are all for selecting numbers
    //they all check to see if that selection was the third number
    //if it is the third number, the check functions will run
    //if all functions return true, a point is awarded and feed is given three new numbers
    @IBAction func pressButtonOne(_ sender: UIButton) {
        if feed.count == 0{
            return
        }
        else{
            userInput.append(feed[0])
            if userInput.count == 3{
                if checkTen(array:userInput) == true{
                    print("you hit a 10")
                    score += 1
                    scoreBoard.text = String(score)
                    feed = threeNew(arrayFeed: feed, arrayInput: userInput)
                    buttonOne.setTitle(String(feed[0]), for: .normal)
                    buttonTwo.setTitle(String(feed[1]), for: .normal)
                    buttonThree.setTitle(String(feed[2]), for: .normal)
                    buttonFour.setTitle(String(feed[3]), for: .normal)
                    buttonFive.setTitle(String(feed[4]), for: .normal)
                    buttonSix.setTitle(String(feed[5]), for: .normal)
                    buttonSeven.setTitle(String(feed[6]), for: .normal)
                    buttonEight.setTitle(String(feed[7]), for: .normal)
                    buttonNine.setTitle(String(feed[8]), for: .normal)
                    userInput = []
                    seconds = 13
                    if score >= 10{
                        seconds = 9
                    }
                    if score >= 20{
                        seconds = 7
                    }
                    if score >= 30{
                        seconds = 4
                    }
                }
                else{
                    playButton.isEnabled = true
                    print("you lose!")
                    feed = []
                    userInput = []
                    youLose.text = "You lose!"
                    timer.invalidate()
                }
            }
        }
    }
    @IBAction func pressButtonTwo(_ sender: UIButton) {
        if feed.count == 0{
            return
        }
        else{
            userInput.append(feed[1])
            if userInput.count == 3{
                if checkTen(array:userInput) == true{
                    print("you hit a 10")
                    score += 1
                    scoreBoard.text = String(score)
                    feed = threeNew(arrayFeed: feed, arrayInput: userInput)
                    buttonOne.setTitle(String(feed[0]), for: .normal)
                    buttonTwo.setTitle(String(feed[1]), for: .normal)
                    buttonThree.setTitle(String(feed[2]), for: .normal)
                    buttonFour.setTitle(String(feed[3]), for: .normal)
                    buttonFive.setTitle(String(feed[4]), for: .normal)
                    buttonSix.setTitle(String(feed[5]), for: .normal)
                    buttonSeven.setTitle(String(feed[6]), for: .normal)
                    buttonEight.setTitle(String(feed[7]), for: .normal)
                    buttonNine.setTitle(String(feed[8]), for: .normal)
                    userInput = []
                    seconds = 13
                    if score >= 10{
                        seconds = 9
                    }
                    if score >= 20{
                        seconds = 7
                    }
                    if score >= 30{
                        seconds = 4
                    }
                }
                else{
                    playButton.isEnabled = true
                    print("you lose!")
                    feed = []
                    userInput = []
                    youLose.text = "You lose!"
                    timer.invalidate()
                }
            }
        }
    }
    @IBAction func pressButtonThree(_ sender: UIButton) {
        if feed.count == 0{
            return
        }
        else{
            userInput.append(feed[2])
            if userInput.count == 3{
                if checkTen(array:userInput) == true{
                    print("you hit a 10")
                    score += 1
                    scoreBoard.text = String(score)
                    feed = threeNew(arrayFeed: feed, arrayInput: userInput)
                    buttonOne.setTitle(String(feed[0]), for: .normal)
                    buttonTwo.setTitle(String(feed[1]), for: .normal)
                    buttonThree.setTitle(String(feed[2]), for: .normal)
                    buttonFour.setTitle(String(feed[3]), for: .normal)
                    buttonFive.setTitle(String(feed[4]), for: .normal)
                    buttonSix.setTitle(String(feed[5]), for: .normal)
                    buttonSeven.setTitle(String(feed[6]), for: .normal)
                    buttonEight.setTitle(String(feed[7]), for: .normal)
                    buttonNine.setTitle(String(feed[8]), for: .normal)
                    userInput = []
                    seconds = 13
                    if score >= 10{
                        seconds = 9
                    }
                    if score >= 20{
                        seconds = 7
                    }
                    if score >= 30{
                        seconds = 4
                    }
                }
                else{
                    playButton.isEnabled = true
                    print("you lose!")
                    feed = []
                    userInput = []
                    youLose.text = "You lose!"
                    timer.invalidate()
                }
            }
        }
    }
    @IBAction func pressButtonFour(_ sender: UIButton) {
        if feed.count == 0{
            return
        }
        else{
            userInput.append(feed[3])
            if userInput.count == 3{
                if checkTen(array:userInput) == true{
                    print("you hit a 10")
                    score += 1
                    scoreBoard.text = String(score)
                    feed = threeNew(arrayFeed: feed, arrayInput: userInput)
                    buttonOne.setTitle(String(feed[0]), for: .normal)
                    buttonTwo.setTitle(String(feed[1]), for: .normal)
                    buttonThree.setTitle(String(feed[2]), for: .normal)
                    buttonFour.setTitle(String(feed[3]), for: .normal)
                    buttonFive.setTitle(String(feed[4]), for: .normal)
                    buttonSix.setTitle(String(feed[5]), for: .normal)
                    buttonSeven.setTitle(String(feed[6]), for: .normal)
                    buttonEight.setTitle(String(feed[7]), for: .normal)
                    buttonNine.setTitle(String(feed[8]), for: .normal)
                    userInput = []
                    seconds = 13
                    if score >= 10{
                        seconds = 9
                    }
                    if score >= 20{
                        seconds = 7
                    }
                    if score >= 30{
                        seconds = 4
                    }
                }
                else{
                    playButton.isEnabled = true
                    print("you lose!")
                    feed = []
                    userInput = []
                    youLose.text = "You lose!"
                    timer.invalidate()
                }
            }
        }
    }
    @IBAction func pressButtonFive(_ sender: UIButton) {
        if feed.count == 0{
            return
        }
        else{
            userInput.append(feed[4])
            if userInput.count == 3{
                if checkTen(array:userInput) == true{
                    print("you hit a 10")
                    score += 1
                    scoreBoard.text = String(score)
                    feed = threeNew(arrayFeed: feed, arrayInput: userInput)
                    buttonOne.setTitle(String(feed[0]), for: .normal)
                    buttonTwo.setTitle(String(feed[1]), for: .normal)
                    buttonThree.setTitle(String(feed[2]), for: .normal)
                    buttonFour.setTitle(String(feed[3]), for: .normal)
                    buttonFive.setTitle(String(feed[4]), for: .normal)
                    buttonSix.setTitle(String(feed[5]), for: .normal)
                    buttonSeven.setTitle(String(feed[6]), for: .normal)
                    buttonEight.setTitle(String(feed[7]), for: .normal)
                    buttonNine.setTitle(String(feed[8]), for: .normal)
                    userInput = []
                    seconds = 13
                    if score >= 10{
                        seconds = 9
                    }
                    if score >= 20{
                        seconds = 7
                    }
                    if score >= 30{
                        seconds = 4
                    }
                }
                else{
                    playButton.isEnabled = true
                    print("you lose!")
                    feed = []
                    userInput = []
                    youLose.text = "You lose!"
                    timer.invalidate()
                }
            }
        }
    }
    @IBAction func pressButtonSix(_ sender: UIButton) {
        if feed.count == 0{
            return
        }
        else{
            userInput.append(feed[5])
            if userInput.count == 3{
                if checkTen(array:userInput) == true{
                    print("you hit a 10")
                    score += 1
                    scoreBoard.text = String(score)
                    feed = threeNew(arrayFeed: feed, arrayInput: userInput)
                    buttonOne.setTitle(String(feed[0]), for: .normal)
                    buttonTwo.setTitle(String(feed[1]), for: .normal)
                    buttonThree.setTitle(String(feed[2]), for: .normal)
                    buttonFour.setTitle(String(feed[3]), for: .normal)
                    buttonFive.setTitle(String(feed[4]), for: .normal)
                    buttonSix.setTitle(String(feed[5]), for: .normal)
                    buttonSeven.setTitle(String(feed[6]), for: .normal)
                    buttonEight.setTitle(String(feed[7]), for: .normal)
                    buttonNine.setTitle(String(feed[8]), for: .normal)
                    userInput = []
                    seconds = 13
                    if score >= 10{
                        seconds = 9
                    }
                    if score >= 20{
                        seconds = 7
                    }
                    if score >= 30{
                        seconds = 4
                    }
                }
                else{
                    playButton.isEnabled = true
                    print("you lose!")
                    feed = []
                    userInput = []
                    youLose.text = "You lose!"
                    timer.invalidate()
                }
            }
        }
    }
    @IBAction func pressButtonSeven(_ sender: UIButton) {
        if feed.count == 0{
            return
        }
        else{
            userInput.append(feed[6])
            if userInput.count == 3{
                if checkTen(array:userInput) == true{
                    print("You lost!")
                    score += 1
                    scoreBoard.text = String(score)
                    feed = threeNew(arrayFeed: feed, arrayInput: userInput)
                    buttonOne.setTitle(String(feed[0]), for: .normal)
                    buttonTwo.setTitle(String(feed[1]), for: .normal)
                    buttonThree.setTitle(String(feed[2]), for: .normal)
                    buttonFour.setTitle(String(feed[3]), for: .normal)
                    buttonFive.setTitle(String(feed[4]), for: .normal)
                    buttonSix.setTitle(String(feed[5]), for: .normal)
                    buttonSeven.setTitle(String(feed[6]), for: .normal)
                    buttonEight.setTitle(String(feed[7]), for: .normal)
                    buttonNine.setTitle(String(feed[8]), for: .normal)
                    userInput = []
                    seconds = 13
                    if score >= 10{
                        seconds = 9
                    }
                    if score >= 20{
                        seconds = 7
                    }
                    if score >= 30{
                        seconds = 4
                    }
                }
                else{
                    playButton.isEnabled = true
                    print("you lose!")
                    feed = []
                    userInput = []
                    youLose.text = "You lose!"
                    timer.invalidate()
                }
            }
        }
    }
    @IBAction func pressButtonEight(_ sender: UIButton) {
        if feed.count == 0{
            return
        }
        else{
            userInput.append(feed[7])
            if userInput.count == 3{
                if checkTen(array:userInput) == true{
                    print("You lost!")
                    score += 1
                    scoreBoard.text = String(score)
                    feed = threeNew(arrayFeed: feed, arrayInput: userInput)
                    buttonOne.setTitle(String(feed[0]), for: .normal)
                    buttonTwo.setTitle(String(feed[1]), for: .normal)
                    buttonThree.setTitle(String(feed[2]), for: .normal)
                    buttonFour.setTitle(String(feed[3]), for: .normal)
                    buttonFive.setTitle(String(feed[4]), for: .normal)
                    buttonSix.setTitle(String(feed[5]), for: .normal)
                    buttonSeven.setTitle(String(feed[6]), for: .normal)
                    buttonEight.setTitle(String(feed[7]), for: .normal)
                    buttonNine.setTitle(String(feed[8]), for: .normal)
                    userInput = []
                    seconds = 13
                    if score >= 10{
                        seconds = 9
                    }
                    if score >= 20{
                        seconds = 7
                    }
                    if score >= 30{
                        seconds = 4
                    }
                }
                else{
                    playButton.isEnabled = true
                    print("you lose!")
                    feed = []
                    userInput = []
                    youLose.text = "You lose!"
                    timer.invalidate()
                }
            }
        }
    }
    @IBAction func pressButtonNine(_ sender: UIButton) {
        if feed.count == 0{
            return
        }
        else{
            userInput.append(feed[8])
            if userInput.count == 3{
                if checkTen(array:userInput) == true{
                    print("You lost!")
                    score += 1
                    scoreBoard.text = String(score)
                    feed = threeNew(arrayFeed: feed, arrayInput: userInput)
                    buttonOne.setTitle(String(feed[0]), for: .normal)
                    buttonTwo.setTitle(String(feed[1]), for: .normal)
                    buttonThree.setTitle(String(feed[2]), for: .normal)
                    buttonFour.setTitle(String(feed[3]), for: .normal)
                    buttonFive.setTitle(String(feed[4]), for: .normal)
                    buttonSix.setTitle(String(feed[5]), for: .normal)
                    buttonSeven.setTitle(String(feed[6]), for: .normal)
                    buttonEight.setTitle(String(feed[7]), for: .normal)
                    buttonNine.setTitle(String(feed[8]), for: .normal)
                    userInput = []
                    seconds = 13
                    if score >= 10{
                        seconds = 9
                    }
                    if score >= 20{
                        seconds = 7
                    }
                    if score >= 30{
                        seconds = 4
                    }
                }
                else{
                    playButton.isEnabled = true
                    print("you lose!")
                    feed = []
                    userInput = []
                    youLose.text = "You lose!"
                    timer.invalidate()
                }
            }
        }
    }
    
    
}

