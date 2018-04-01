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
            self.movableImageDelegate?.addCarCollision(barrierName: "mainCar", image: self)
        }
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            let currentLocation = touches.first?.location(in:self)
            let dx = currentLocation!.x - startLocation!.x
            let dy = currentLocation!.y - startLocation!.y
            self.center = CGPoint(x:self.center.x+dx,y:self.center.y+dy)
            
            self.movableImageDelegate?.addCarCollision(barrierName: "mainCar", image: self)
        }
        
    

}
