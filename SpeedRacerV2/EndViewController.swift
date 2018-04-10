//
//  EndViewController.swift
//  SpeedRacerV2
//
//  Created by Hannah Bbaale on 30/03/2018.
//  Copyright © 2018 com.EngineersParadise. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

   
    @IBAction func replyClicked(_ sender: Any) {
        performSegue(withIdentifier: "replySegue", sender: self)
        let mainview = storyboard?.instantiateViewController(withIdentifier: "mainController") as! RacerMainController
        let behaviour = mainview.speedRacerBehaviour
        behaviour?.startAgainCleanUp()
        mainview.timer = Timer.scheduledTimer(timeInterval: 20, target: mainview, selector: #selector(RacerMainController.dispatchtofinishgame), userInfo: nil, repeats: true)
        mainview.gamePlayer?.play()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainview = storyboard?.instantiateViewController(withIdentifier: "mainController") as! RacerMainController
        mainview.soundTimer.invalidate()
        mainview.gamePlayer?.stop()
        
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
