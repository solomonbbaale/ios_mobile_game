//
//  RacerBehaviour.swift
//  SpeedRacer
//
//  Created by Solomon Bbaale on 19/03/2018.
//  Copyright © 2018 com.EngineersParadise. All rights reserved.
//

import UIKit

class SpeedRacerBehaviour: UIDynamicBehavior, UICollisionBehaviorDelegate {
    
    
    
    
    let gravityBehaviour = UIGravityBehavior()
    let collisionBehaviour = UICollisionBehavior()
    let dynamicItemBehaviour = UIDynamicItemBehavior()
    var controller:RacerMainController! = nil
    
    var score = 0
    
    override init() {
        super.init()
        
        addChildBehavior(gravityBehaviour)
        addChildBehavior(collisionBehaviour)
        addChildBehavior(dynamicItemBehaviour)
        collisionBehaviour.collisionDelegate = self
    }
    init(controller:RacerMainController){
        super.init()
        addChildBehavior(gravityBehaviour)
        addChildBehavior(collisionBehaviour)
        addChildBehavior(dynamicItemBehaviour)
        collisionBehaviour.collisionDelegate = self
        self.controller = controller
        self.setcollisionDelegateListener()
        
    }
    
    
    func addCar(collisionObstacle: UIImageView){
        self.dynamicAnimator?.referenceView?.addSubview(collisionObstacle)
        let image = collisionObstacle as! SpeedRacerCustomImage
        if(image.imageTag=="car"){
        dynamicItemBehaviour.addItem(collisionObstacle)
        self.addLinearVelocityForItem(collisionObstacle: collisionObstacle)
        
        }
        gravityBehaviour.addItem(collisionObstacle)
        collisionBehaviour.addItem(collisionObstacle)
        
    }
    func removeCar(collisionObstacle: UIImageView){
        dynamicItemBehaviour.removeItem(collisionObstacle)
        dynamicItemBehaviour.linearVelocity(for: collisionObstacle)
        gravityBehaviour.removeItem(collisionObstacle)
        collisionBehaviour.removeItem(collisionObstacle)
        collisionObstacle.removeFromSuperview()
    }
    func cleanup(){
        for  view  in collisionBehaviour.items{
            collisionBehaviour.removeItem(view)
            dynamicItemBehaviour.removeItem(view)
            gravityBehaviour.removeItem(view)
            //view.removeFromSuperView()
            
        }
        
    }
    
    //Random number generator
    
    func random(_ range:Range<Int>) -> Int {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    
    
    
    //@objc public func addCarCollision(barrierName :String, mainCar: UIImageView){
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        //print("called this again")
        //let items = item as! CustomUIIMageView
        //print(items.imageTag!)
        // let viewcontroller = controller as! ViewController
        //viewcontroller.score -= 10
        //viewcontroller.ScoreKeeper.text = String(score)
        let mainitem = item as! SpeedRacerCustomImage
        
        if(mainitem.imageTag! == "car"){
            if let score = controller?.score{
                if(score != 0){
                    controller?.score = (controller?.score)! - 10
                }
            }
            //let score = controller!.score
            //controller.scoreBoard?.text = "Score: \(String(describing: score))"
            
        }else if(mainitem.imageTag! == "coin"){
            self.removeCar(collisionObstacle: item as! UIImageView)
            
            controller.score = (controller.score)! + 20
            //let score = controller!.score
            //controller.scoreBoard?.text = "Score: \(String(describing: score))"
        }
        
        removeOutOfBoundsSubViews()
        
        
    }
    
    func removeOutOfBoundsSubViews(){
        let view = self.dynamicAnimator?.referenceView!
        for subview in (view?.subviews)!{
            //print("the subview is \(subview)")
            let frame = subview.frame
            if(frame.maxY > (view?.bounds.height)!){
                self.removeCar(collisionObstacle: subview as! UIImageView)
            }
        }
        
    }
    
    func startAgainCleanUp(){
        let view = self.dynamicAnimator?.referenceView!
        for subview in (view?.subviews)!{
            //print("the subview is \(subview)")
            //let frame = subview.frame
            self.removeCar(collisionObstacle: subview as! UIImageView)
            
        }
        
    }
    
    
    func setcollisionDelegateListener(){
     controller?.mainCar.movableImageDelegate = self
    }
    
    
    
}
extension SpeedRacerBehaviour : collisionDelegate {
   
    @objc func addCarCollision(_ timer:Timer){
        let result = timer.userInfo as! Dictionary<String,Any>
        let barrierName = (result["barrierName"] as! String)
        let mainCar = (result["mainCar"] as! UIImageView)
        
        //let barrierName = data.barrierName!
        
        collisionBehaviour.removeAllBoundaries()
        collisionBehaviour.addBoundary(withIdentifier: barrierName as NSCopying, for: UIBezierPath(rect:mainCar.frame))
        //collisionBehaviour.collisionDelegate = dynamicAnimator?.referenceView as? UICollisionBehaviorDelegate
        collisionBehaviour.collisionDelegate = self
    }
    
    
    func addLinearVelocityForItem(collisionObstacle:UIImageView){
        let cointoss = arc4random_uniform(5)
        let interval = random(300..<700)
        
        
        switch cointoss {
        case 0,1:
            self.dynamicItemBehaviour.addLinearVelocity(CGPoint(x:0,y:interval), for: collisionObstacle)
            self.dynamicItemBehaviour.elasticity = 0.2
            self.dynamicItemBehaviour.resistance = 0.4
            self.dynamicItemBehaviour.charge = .greatestFiniteMagnitude
            self.dynamicItemBehaviour.allowsRotation = false
            break
        case 2,3:
            self.dynamicItemBehaviour.addLinearVelocity(CGPoint(x:0,y:300), for: collisionObstacle)
            self.dynamicItemBehaviour.elasticity = 0.4
            self.dynamicItemBehaviour.resistance = 0.2
            self.dynamicItemBehaviour.charge = .greatestFiniteMagnitude
            self.dynamicItemBehaviour.allowsRotation = false
            break
        default:
            self.dynamicItemBehaviour.addLinearVelocity(CGPoint(x:0,y:interval), for: collisionObstacle)
            self.dynamicItemBehaviour.elasticity = 0.5;
            self.dynamicItemBehaviour.resistance = 0.1
            self.dynamicItemBehaviour.charge = .greatestFiniteMagnitude
            self.dynamicItemBehaviour.allowsRotation = false
            
        }
    }
    
    @objc func addCarCollision(barrierName: String, image:MovableUIIMageView){
        
        
        
        collisionBehaviour.removeAllBoundaries()
        collisionBehaviour.addBoundary(withIdentifier: barrierName as NSCopying, for: UIBezierPath(rect:image.frame))
        //collisionBehaviour.collisionDelegate = dynamicAnimator?.referenceView as? UICollisionBehaviorDelegate
        collisionBehaviour.collisionDelegate = self
        
        
    }
    
}
