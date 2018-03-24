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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
