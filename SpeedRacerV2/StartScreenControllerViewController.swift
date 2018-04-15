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
        startButton.adjustsImageWhenHighlighted = false
        //DispatchQueue.main.asyncAfter(deadline: delayBeforeGameEnds)
        //startButton.showsTouchWhenHighlighted = true
           // startscreenbuttonplacer.layer.masksToBounds = true
        //startscreenbuttonplacer.layer.borderColor = UIColor.gray.cgColor
        //startscreenbuttonplacer.layer.cornerRadius = 5
        
    
        //startButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        //startButton.layer.shadowRadius = 5
       // startButton.layer.shadowOpacity = 1.0
        //dispatchtogame()
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
       // animateButton(sender: startButton)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var startscreenbuttonplacer: UIImageView!
    
    //from stackoverflow
    //https://stackoverflow.com/questions/31320819/scale-uibutton-animation-swift
    
    @IBAction func animateButton(sender: UIButton) {
        
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
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
