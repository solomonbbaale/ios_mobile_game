//
//  RacerBehaviour.swift
//  SpeedRacer
//
//  Created by Solomon Bbaale on 19/03/2018.
//  Copyright © 2018 com.EngineersParadise. All rights reserved.
//

import UIKit

class SpeedRacerBehaviour: UIDynamicBehavior, UICollisionBehaviorDelegate{
    
    
    
    
    let gravityBehaviour = UIGravityBehavior()
    let collisionBehaviour = UICollisionBehavior()
    let dynamicItemBehaviour = UIDynamicItemBehavior()
    var controller:UIViewController? = nil
    
    var score = 0
    
    override init() {
        super.init()
        addChildBehavior(gravityBehaviour)
        addChildBehavior(collisionBehaviour)
        collisionBehaviour.collisionDelegate = self
    }
    init(controller:UIViewController){
        super.init()
        addChildBehavior(gravityBehaviour)
        addChildBehavior(collisionBehaviour)
        collisionBehaviour.collisionDelegate = self
        self.controller = controller
        
    }
    
    
    func addCar(car: UIImageView){
        self.dynamicAnimator?.referenceView?.addSubview(car)
        dynamicItemBehaviour.addItem(car)
        gravityBehaviour.addItem(car)
        collisionBehaviour.addItem(car)
        
    }
    func removeCar(car: UIImageView){
        dynamicItemBehaviour.removeItem(car)
        dynamicItemBehaviour.linearVelocity(for: car)
        gravityBehaviour.removeItem(car)
        collisionBehaviour.removeItem(car)
        car.removeFromSuperview()
    }
    func cleanup(){
        for  view  in collisionBehaviour.items{
            collisionBehaviour.removeItem(view)
            dynamicItemBehaviour.removeItem(view)
            gravityBehaviour.removeItem(view)
            //view.removeFromSuperView()
            
        }
        
    }
    //@objc public func addCarCollision(barrierName :String, mainCar: UIImageView){
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        print("called this again")
        //let items = item as! CustomUIIMageView
        //print(items.imageTag!)
        // let viewcontroller = controller as! ViewController
        //viewcontroller.score -= 10
        //viewcontroller.ScoreKeeper.text = String(score)
        
        
        
        
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
    
}
