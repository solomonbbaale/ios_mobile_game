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
        let viewwidth = UIScreen.main.bounds.size.width
        let viewheight = UIScreen.main.bounds.size.height
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            startLocation = touches.first?.location(in:self)
            self.movableImageDelegate?.addCarCollision(barrierName: "mainCar", image: self)
        }
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            let currentLocation = touches.first?.location(in:self)
            let dx = currentLocation!.x - startLocation!.x
            let dy = currentLocation!.y - startLocation!.y
            
            var actualx = dx+self.center.x
            var actualy = dy+self.center.y
            
            if outOfboundsHelperX(x:actualx) != nil{
                actualx = outOfboundsHelperX(x: actualx)!
            }
            if outOfboundsHelperY(y: actualy) != nil{
                actualy = outOfboundsHelperY(y: actualy)!
            }
            
            self.center = CGPoint(x:actualx,y:actualy)
            
            self.movableImageDelegate?.addCarCollision(barrierName: "mainCar", image: self)
        }
    
       func outOfboundsHelperX(x:CGFloat)->CGFloat?{
        
        //CODE IDEA FROM
        //http://iosdevelopertips.com/graphics/drag-an-image-within-the-bounds-of-superview.html
        let midpointx = viewwidth/12.5
        var result:CGFloat? = nil
        
        
        
        if(x>(viewwidth-midpointx)){
            result = viewwidth - midpointx
        
        }else if(x < midpointx){
            result = midpointx
        }
        //print("the result of y is \()")
        return result
       }
    
    
    func outOfboundsHelperY(y:CGFloat)->CGFloat?{
        
        //CODE IDEA FROM
        //http://iosdevelopertips.com/graphics/drag-an-image-within-the-bounds-of-superview.html
        
        let midpointy = viewheight/10.00
        var result:CGFloat?
        
        if(y>(viewheight-midpointy)){
            result = viewheight - midpointy
            
        }else if(y < midpointy){
            result = midpointy
        }
       // print("the result of y is \(result!)")
        return result
        
    }
    

}
