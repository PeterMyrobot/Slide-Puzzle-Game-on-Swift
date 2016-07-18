 //
//  ViewController.swift
//  SlidePuzzleII
//
//  Created by apple on 27/05/2016.
//  Copyright © 2016 Peter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var leaderboardData: NSUserDefaults!
    
    var leaderboardNameArray = ["Peter", "Limi", "-", "-", "-", "-", "-", "-", "-", "-"]
    var leaderboardStepArray = [123, 155, 999, 999, 999, 999, 999, 999, 999, 999]
    var leaderboardTimArray = [870, 930, 999, 999, 999, 999, 999, 999, 999, 999]
    
    @IBOutlet var blocks: [UILabel]!
    @IBOutlet weak var stepCounter: UILabel!
    @IBOutlet weak var timeCounter: UILabel!
    @IBAction func restartBtn(sender: UIButton) {
        timer.invalidate()
        generateArray()
        
    }

    var blockPosition:[Int] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    var randomArray:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var isPlayerStartorNot = false
    var stepCount = 0
    
    var seconds = 1
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaderboardData = NSUserDefaults.standardUserDefaults()
        
        if let name = leaderboardData.objectForKey("name") as? [String]{
            leaderboardNameArray = name
        }
        if let step = leaderboardData.objectForKey("step") as? [Int]{
            leaderboardStepArray = step
        }
        if let time = leaderboardData.objectForKey("time") as? [Int]{
            leaderboardTimArray = time
        }
        
        generateArray()
        
        for i in 0..<blocks.count{
            blocks[i].layer.cornerRadius = 10
            blocks[i].clipsToBounds = true
        }
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respond(_:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respond(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respond(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respond(_:)))
        rightSwipe.direction = .Right
        leftSwipe.direction = .Left
        upSwipe.direction = .Up
        downSwipe.direction = .Down
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showLeaderboard" {
            let destinationController = segue.destinationViewController as! LeaderboardViewController
            destinationController.leaderboardNameArray = (leaderboardData.objectForKey("name") as? [String])!
            destinationController.leaderboardStepArray = (leaderboardData.objectForKey("step") as? [Int])!

        }
    }
    @IBAction func close(segue: UIStoryboardSegue){
        generateArray()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func respond(gesture: UISwipeGestureRecognizer){
        let swipeGsture = gesture as UISwipeGestureRecognizer
        if let blankblok = randomArray.indexOf(0){
            switch swipeGsture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                if blankblok % 4 != 0{
                    changeBlock(blankblok, changeNumber: blankblok - 1)
                }
            case UISwipeGestureRecognizerDirection.Left:
                if blankblok % 4 != 3{
                    changeBlock(blankblok, changeNumber: blankblok + 1)
                }
                
            case UISwipeGestureRecognizerDirection.Up:
                switch blankblok {
                case 12,13,14,15:
                    break
                default:
                    changeBlock(blankblok, changeNumber: blankblok + 4)
                }
                
            case UISwipeGestureRecognizerDirection.Down:
                switch blankblok {
                case 0,1,2,3:
                    break
                default:
                    changeBlock(blankblok, changeNumber: blankblok - 4)
                }
                
            default:
                break
            }
        }
        
    }
    
    func changeBlock(blank: Int,changeNumber: Int){
        if isPlayerStartorNot == false{
            seconds = 0
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
            isPlayerStartorNot = true
        }
        randomArray[blank] = randomArray[changeNumber]
        randomArray[changeNumber] = 0
        stepCount += 1
        for v in 0...15{
            if randomArray[v] != 0{
                blocks[v].text = "\(randomArray[v])"
            }else{
                blocks[v].text = ""
            }
        }
        stepCounter.text = "Steps you take : \(stepCount)"
        if randomArray == blockPosition{
            timer.invalidate()
            let alertController = UIAlertController(title: "Congratulation!", message: "You solve this problem\n Used \(stepCount) steps and \(seconds/10).\(seconds%10)s", preferredStyle: UIAlertControllerStyle.Alert)
            for x in leaderboardStepArray{
                if stepCount < x{
                    let index = leaderboardStepArray.indexOf(x)
                    alertController.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                        textField.text = "Enter your name."})
                    alertController.addAction(UIAlertAction(title: "Resign", style: .Default, handler: { (action) -> Void in
                        let textField = (alertController.textFields?[0])! as UITextField
                        print("Text field: \(textField)")
                        self.leaderboardNameArray.insert(textField.text!, atIndex: index!)
                        self.leaderboardNameArray.removeLast()
                        self.leaderboardStepArray.insert(self.stepCount, atIndex: index!)
                        self.leaderboardStepArray.removeLast()
                        self.leaderboardTimArray.insert(self.seconds, atIndex: index!)
                        self.leaderboardTimArray.removeLast()
                        
                        self.leaderboardData.setObject(self.leaderboardNameArray, forKey: "name")
                        self.leaderboardData.setObject(self.leaderboardStepArray, forKey: "step")
                        self.leaderboardData.setObject(self.leaderboardTimArray, forKey: "time")
                        self.leaderboardData.synchronize()
                        
                    }))
                    break
                }
            }
            alertController.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) in
                self.generateArray()
                
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    func updateTimer(){
        seconds += 1
        timeCounter.text = "Time you take: \(seconds/10).\(seconds%10)"
    }
    
    
    func generateArray(){//Generate an array and check if it is solvable or not
        
                if let nameArray = leaderboardData.objectForKey("name"){
                    print("\(nameArray)")
                }
                if let stepArray = leaderboardData.objectForKey("step"){
                    print("\(stepArray)")
                }
                if let timeArray = leaderboardData.objectForKey("time"){
                    print("\(timeArray)")
                }
        var inversecount = 0
        var thisArrayCanSolveorNot = false
        isPlayerStartorNot = false
        seconds = 0
        stepCount = 0
        timeCounter.text = "Time: \(seconds/10).\(seconds%10)"
        stepCounter.text = "Steps: \(stepCount)"

        while !thisArrayCanSolveorNot{
            
            //test code one step finish!
//            blockPosition = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0]
//            randomArray = [1,2,3,4,5,6,7,8,9,0,10,12,13,14,11,15]
//            for i in 0...15{
//                if randomArray[i] != 0{
//                    blocks[i].text = "\(randomArray[i])"
//                }else{
//                    blocks[i].text = ""
//                }
//            }
//            thisArrayCanSolveorNot = true

            
            var count: UInt32 = 16
            for i in 0..<16{
                let randomRoll = Int(arc4random_uniform(count))
                randomArray[i] = blockPosition[randomRoll]
                blockPosition.removeAtIndex(randomRoll)
                count -= 1
            }
            print("LOOP")
            blockPosition = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0]
            if let zero = randomArray.indexOf(0){
                randomArray.removeAtIndex(zero)
                for i in 0..<16{
                    for j in i..<randomArray.count{
                        if randomArray[i] > randomArray[j]{
                            inversecount += 1
                        }
                    }
                }
                if (zero / 4 == 0 || zero / 4 == 2) && inversecount % 2 == 1{
                    thisArrayCanSolveorNot = true
                }else if (zero / 4 == 1 || zero / 4 == 3 ) && inversecount % 2 == 0{
                    thisArrayCanSolveorNot = true
                }else{
                    thisArrayCanSolveorNot = false
                }
                randomArray.insert(0, atIndex: zero)
                for i in 0...15{
                    if randomArray[i] != 0{
                        blocks[i].text = "\(randomArray[i])"
                    }else{
                        blocks[i].text = ""
                    }
                }
            }
        }
    }
 }

