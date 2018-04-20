//
//  EndViewController.swift
//  SpeedRacerV2
//
//  Created by Hannah Bbaale on 30/03/2018.
//  Copyright © 2018 com.EngineersParadise. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

    var endscore = 0
    @IBOutlet weak var FinalScore: UILabel!
    
    @IBAction func replyClicked(_ sender: Any) {
        performSegue(withIdentifier: "replySegue", sender: self)
        let mainview = storyboard?.instantiateViewController(withIdentifier: "mainController") as! RacerMainController
        mainview.explosionPlayer?.stop()
        let behaviour = mainview.speedRacerBehaviour
        behaviour?.removeOutOfBoundsSubViews()
        behaviour?.startAgainCleanUp()
        mainview.timer = Timer.scheduledTimer(timeInterval: 20, target: mainview, selector: #selector(RacerMainController.dispatchtofinishgame), userInfo: nil, repeats: true)
        mainview.gamePlayer?.play()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainview = storyboard?.instantiateViewController(withIdentifier: "mainController") as! RacerMainController
        //mainview.speedRacerBehaviour.removeOutOfBoundsSubViews()
        mainview.soundTimer.invalidate()
        self.FinalScore.textAlignment = .left
        self.FinalScore?.text =  "YOUR SCORE:      \(self.endscore)"

        let topscore = UserDefaults.standard.object(forKey:"topscore")
        let b = "BEST SCORE:            \(topscore as! Int)"
        self.BestScores?.text = b
        mainview.gamePlayer?.stop()
        
        // Do any additional setup after loading the view.
    }
   
    @IBOutlet weak var BestScores: UILabel!
    @IBOutlet var BestScore: UIView!
    @IBAction func unwind(_ sender: UIStoryboardSegue) {
        if let originvc = sender.source as? RacerMainController{
            self.endscore = originvc.score
        }
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

    override func viewDidAppear(_ animated: Bool) {
        self.endscore = 200
    }
   
}
