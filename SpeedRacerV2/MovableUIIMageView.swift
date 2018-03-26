//
//  MovableUIIMageView.swift
//  SpeedRacerV2
//
//  Created by Solomon Bbaale on 25/03/2018.
//  Copyright © 2018 com.EngineersParadise. All rights reserved.
//

import UIKit

class MovableUIIMageView: UIImageView {

    
        var startLocation: CGPoint?
        //this is responsible for always invoking the collision delegate that the behaviour is waiting to respond to
        var movableImageDelegate: collisionDelegate?
        var newtimer: Timer = Timer()
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            startLocation = touches.first?.location(in:self)
            print("began")
        }
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            let currentLocation = touches.first?.location(in:self)
            let dx = currentLocation!.x - startLocation!.x
            let dy = currentLocation!.y - startLocation!.y
            print("touches moved")
            //self.center = CGPointMake(self.center.x+dx, self.center.y+dy)
            self.center = CGPoint(x:self.center.x+dx,y:self.center.y+dy)
            if movableImageDelegate != nil{
                print("got something form the subtypes")
            }
            //invoking the addCarCollision every time the
            //newtimer = Timer.scheduledTimer(timeInterval: 0.01, target:self.movableImageDelegate!, selector: #selector(self.movableImageDelegate?.addCarCollision), userInfo:["barrierName":"mainCar","mainCar":self], repeats:true)
            //self.movableImageDelegate?.addCarCollision(newtimer)
            self.movableImageDelegate?.addCarCollision(barrierName: "mainCar", image: self)
        }
        
    

}
