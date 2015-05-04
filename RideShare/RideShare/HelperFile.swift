//
//  calculatorBrain.swift
//  Calculator
//
//  Created by Era Chaudhary on 3/15/15.
//  Copyright (c) 2015 Era Chaudhary. All rights reserved.
//

import Foundation
class calculatorBrain : UIViewController, UITableViewDataSource{
    
    
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        if indexPath.section == 0 {
            let (courseTitle,courseAuthor) = devCourses[indexPath.row]
            cell.textLabel?.text = courseTitle
            cell.detailTextLabel?.text = courseAuthor
        } else {
            let (courseTitle,courseAuthor) = webCourses[indexPath.row]
            cell.textLabel?.text = courseTitle
            cell.detailTextLabel?.text = courseAuthor
        }
        
        // Retrieve an image
        var myImage = UIImage(named: "CellIcon")
        cell.imageView?.image = myImage
        
        
        return cell
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
    
    
}



