//
//  Protocols.swift
//  SpeedRacer
//
//  Created by Hannah Bbaale on 21/03/2018.
//  Copyright © 2018 com.EngineersParadise. All rights reserved.
//

import Foundation

@objc protocol collisionDelegate{
    @objc func addCarCollision(_ timer:Timer)
    @objc func addCarCollision(barrierName: String, image:MovableUIIMageView)
}

