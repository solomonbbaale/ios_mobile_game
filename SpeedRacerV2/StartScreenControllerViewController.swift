//
//  StartScreenControllerViewController.swift
//  SpeedRacerV2
//
//  Created by Hannah Bbaale on 30/03/2018.
//  Copyright © 2018 com.EngineersParadise. All rights reserved.
//

import UIKit

class StartScreenControllerViewController: UIViewController {

    
    var delayBeforeGameEnds = DispatchTime.now() + 20
    
    @IBAction func startGame(_ sender: Any) {
        performSegue(withIdentifier: "startgamesegue", sender: self)
    }
    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //DispatchQueue.main.asyncAfter(deadline: delayBeforeGameEnds)
        startButton.layer.shadowColor = UIColor.blue.cgColor
        startButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        startButton.layer.shadowRadius = 5
        startButton.layer.shadowOpacity = 1.0
        //dispatchtogame()
        
        
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
