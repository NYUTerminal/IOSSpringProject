//
//  calculatorBrain.swift
//  Calculator
//
//  Created by Era Chaudhary on 3/15/15.
//  Copyright (c) 2015 Era Chaudhary. All rights reserved.
//

import Foundation
class calculatorBrain : UIViewController{
    
    
    let devCourses = [
        ("iOS App Dev with Swift Essential Training","Simon Allardice"),
        ("iOS 8 SDK New Features","Lee Brimelow"),
        ("Data Visualization with D3.js","Ray Villalobos"),
        ("Swift Essential Training","Simon Allardice"),
        ("Up and Running with AngularJS","Ray Villalobos"),
        ("MySQL Essential Training","Bill Weinman"),
        ("Building Adaptive Android Apps with Fragments","David Gassner"),
        ("Advanced Unity 3D Game Programming","Michael House"),
        ("Up and Running with Ubuntu Desktop Linux","Scott Simpson"),
        ("Up and Running with C","Dan Gookin") ]
    
    let webCourses = [
        ("HTML Essential Training","James Williamson"),
        ("Building a Responsive Single-Page Design","Ray Villalobos"),
        ("Muse Essential Training","Justin Seeley"),
        ("WordPress Essential Training","Morten Rand-Hendriksen"),
        ("Installing and Running Joomla! 3: Local and Web-Hosted Sites","Jen Kramer"),
        ("Managing Records in SharePoint","Toni Saddler-French"),
        ("Design the Web: SVG Rollovers with CSS","Chris Converse"),
        ("Up and Running with Ember.js","Kai Gittens"),
        ("HTML5 Game Development with Phaser","Joseph Labrecque"),
        ("Responsive Media","Christopher Schmitt") ]
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return devCourses.count
        } else {
            return webCourses.count
        }
    }
    

    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Developer Courses"
        } else {
            return "Web Courses"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private enum Op:Printable{
        
        case operand(Double)
        case unaryOperation(String, Double -> Double)
        case binaryOperation(String, (Double,Double)->Double)
        
        var description:String{
            get{
                switch self{
                    
                case .operand(let operand):
                    return("\(operand)")
                case .binaryOperation(let symbol, _):
                    return symbol
                case .unaryOperation(let symbol, _ ):
                    return symbol
                }
                
            }
            
        }
        
    }
    private var opStack = [Op]()
    private var knownOps = [String:Op]()
    
    
    private  func evaluate(ops:[Op])->(result:Double?, remainingOps:[Op]){
        if !ops.isEmpty{
            var remainingOps = ops
            let op  = remainingOps.removeLast()
            switch op
            {
            case .operand(let operand):
                return (operand,remainingOps)
            case .unaryOperation(_ ,let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result{
                    return(operation(operand),operandEvaluation.remainingOps)
                }
            case .binaryOperation(_,let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result{
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result{
                        return(operation(operand1,operand2),op2Evaluation.remainingOps)
                    }
                }
            }
            
        }
        
        return (nil,ops)
        
        
    }
    
    func evaluate()->Double?{
        let (result,remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) leftover")
        return result
        
        
    }
    
    
    func pushOperand(operand:Double)->Double?{
        opStack.append(Op.operand(operand))
        return evaluate()
        
    }
    
    func performOperation(symbol:String)->Double?{
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
        return evaluate()
    }
    
    var shuffledDeck = Array<Int>()
    
    var deck = Array<Int>()
    
    //var gameProperties = GameProperties.sharedInstance
    
    func buildDeck(var noOfDecks : Int) -> [Int]  {
        //Validation for number of cards
        var Suit = ["Spades","Hearts","Diamonds" , "Clubs"]
        //var Card = ["1","2","3","4","5","6","7","8","9","10","10","10","10"]
        var Card = [1,2,3,4,5,6,7,8,9,10,11,12,13]
        
        for i in 1...noOfDecks
        {
            for suit in Suit
            {
                for card in Card {
                    deck.append(card)
                }
            }
        }
        shuffle()
        shuffledDeck = deck
       // GameProperties.sharedInstance.deck = shuffledDeck
        return shuffledDeck
    }
    
    func shuffle() {
        var temp: Int
        for i in 0...(deck.count-1) {
            let j = Int(arc4random_uniform(UnicodeScalarValue(deck.count)))
            println(j)
            temp = deck[i]
            println(i,j)
            deck[i]=deck[j]
            deck[j]=temp
            
        }
    }
    
    func shuffle<T>(var list: Array<T>) -> Array<T> {
        for i in 0..<list.count {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            list.insert(list.removeAtIndex(j), atIndex: i)
        }
        return list
    }
    
    func getACardFromDeck() -> Int {
        //return GameProperties.sharedInstance.deck.removeAtIndex(0)
        return 0;
    }

    
    var cardsInHand : [Int] = []
    
    //var handStatus : HandStatus
    
    var bet : Int = 0

    
    var handSum : Int {
        get{
            //Logic to get Ace as 1 or 11 is implemented below .
            var tempCount : Int = 0
            var acePresent:Bool = false
            for card in cardsInHand {
                if(card == 1){
                    acePresent = true
                }
                if(card>10){
                    tempCount += 10
                    continue
                }
                tempCount += card
            }
            if(acePresent){
                if(tempCount<21){
                    if(tempCount+10<21){
                        tempCount = tempCount+10
                    }
                }
            }
            //handSum = tempCount
            return tempCount
        }set{
            self.handSum = newValue
        }
    }
    
    func isBlackJack() -> Bool {
        var tempCount = handSum
        if  tempCount == 21 {
            return true
        }
        return false
    }
    
    func isBusted() -> Bool {
        var tempCount = handSum
        
        if tempCount > 21 {
            return true
        }
        return false
        
    }
    
    
    func getAllCardsInString(cardsInHand :[Int]) -> String {
        if(cardsInHand.count==0){
            return ""
        }
        var tempString = ""
        if(cardsInHand[0]==1){
            var tempString = String(cardsInHand[0])+"(11-Ace)"
        }else{
            tempString = String(cardsInHand[0])
        }
        
        if(cardsInHand.count>1){
            for i in 2...cardsInHand.count{
                if(cardsInHand[i-1]==1){
                    tempString = tempString + " , " + String(cardsInHand[i-1])+"(11-Ace)"
                }else{
                    tempString = tempString + " , " + String(cardsInHand[i-1])
                }
            }
        }
        return tempString
    }

    
    
}



