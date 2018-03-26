//
//  RacerMainController.swift
//  SpeedRacerV2
//
//  Created by Solomon Bbaale on 24/03/2018.
//  Copyright © 2018 com.EngineersParadise. All rights reserved.
//

import UIKit

class RacerMainController: UIViewController {

    
    var road = [UIImage]()
    
    
    @IBOutlet var mainRoad: UIImageView!
    
    @IBOutlet weak var mainCar: MovableUIIMageView!
    
    
    
    
    func setRoad(){
        for roadindex in 1...20{
            let currentroad = "road\(roadindex).png"
            let roadimage = UIImage(named:currentroad)
            road.append(roadimage!)
        }
        mainRoad.image = UIImage.animatedImage(with:road, duration: 0.1)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        setRoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
