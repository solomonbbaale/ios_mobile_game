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
    
    //main controller images
    @IBOutlet var mainRoad: UIImageView!
    
    @IBOutlet weak var mainCar: MovableUIIMageView!
    
    
    @IBOutlet weak var scoreBoard: UILabel!
    @IBOutlet weak var countDown: UIImageView!
    //Score stuff
    var score = 0
    
    
    //other variables
    
    let ImagesLocation = "images/"
    var gamewidth = Int(UIScreen.main.bounds.width)
    var gameheight = Int(UIScreen.main.bounds.height)
    var timer:Timer = Timer()
    var delayBeforeGameEnds = DispatchTime.now() + 20
    var createCarObstacleTimer:Timer = Timer()
    var finishviewloaded:Bool = false
    var countdowntimer:Timer = Timer()
    
    //countdown for racing
    var countdownfinished = 0
    
    //behaviour configuration
    var speedRaceDynamicAnimator:UIDynamicAnimator!
    var speedRacerBehaviour:SpeedRacerBehaviour! = nil
    
    
    //setting up finishgame strategy
    @objc func dispatchtofinishgame(){
        DispatchQueue.main.asyncAfter(deadline: delayBeforeGameEnds){
        self.performSegue(withIdentifier: "moveToFinish", sender: self)
        }
    }
    
    
    @objc func countdowntimerfunc(){
        if(self.countdownfinished < 5){
            self.countdownfinished = countdownfinished+1
            self.countDown.image = UIImage(named:"number\(self.countdownfinished).png")
            
            
        }else{
            self.countdowntimer.invalidate()
            self.countDown.isHidden = true
            
            //self.firstroad.isHidden = true
        }
        
    }
    func startCountDown(){
        countdowntimerfunc()
        self.countdowntimer = Timer(timeInterval:0.1, target:self, selector: #selector(RacerMainController.countdowntimerfunc), userInfo: nil, repeats: true)
    }
    
    
    
    //set mainroad for game
    func setRoad(){
        for roadindex in 1...20{
            let currentroad = "road\(roadindex).png"
            let roadimage = UIImage(named:currentroad)
            road.append(roadimage!)
        }
        mainRoad.image = UIImage.animatedImage(with:road, duration: 0.1)
        
    }
   
    func randomNumberbtnpoints(viewwidth:UInt32)->UInt32{
        //http://iphonedevsdk.com/forum/iphone-sdk-development/98043-random-number-between-two-certainnumbers.html
        let leftsmallest = UInt32(200);
        let rightsmallest = UInt32(25);
        let largest = viewwidth;
        let largestused = UInt32(largest+1)
        let firstran =  UInt32(arc4random()) + UInt32(leftsmallest)
        //random number btn 100 and the view width
        let randomnumber =  firstran %  (largestused - rightsmallest)
        
        //let inty = arc4r
        return randomnumber;
    }
    
    //functions to add cars to game
    func gameCars()->[UIImage]{
        
        var cars = [UIImage]()
        for carindex in 0...6{
        
            let car = UIImage(named:"car\(carindex).png")!
            
            cars.append(car)
        }
        
        return cars
    }
    
    
    func createCar()->UIImage{
        var cars = gameCars()
        let carcount = UInt32(cars.count)
        
        var randomnumber = arc4random_uniform(carcount)
        if randomnumber == 0{
            randomnumber = 1
        }
        
        
        
        let randomcarindex = Int(arc4random_uniform(carcount))
        
        let createdCar = cars[randomcarindex]
        
        return createdCar
    }
    
    func createCars()->[UIImage]{
        var cars = gameCars()
        let carcount = UInt32(cars.count)
        
        var randomnumber = arc4random_uniform(carcount)
        if randomnumber == 0{
            randomnumber = 1
        }
        
        
        var randomcars = [UIImage]()
        //how many cars to create
        for _ in 0..<randomnumber {
            let randomcarindex = Int(arc4random_uniform(carcount))
            randomcars.append(cars[randomcarindex])
            //cars.remove(at: randomcarindex)
        }
        return randomcars
    }
    
    
    
    //function to create coins
    func addCoins()->UIImage{
        
        let coin = UIImage(named:"levelupcoin")!
        
        return coin
    }
    
    
    
    @objc func addGameCars(){
        self.createCarObstacleTimer.invalidate();
        //var cars = createCars()
        
        let randomnumber = arc4random_uniform(5)
        
        var createdObstacle:SpeedRacerCustomImage!
        
        switch randomnumber {
        case 0,2,3,5:
            let car = self.createCar()
            createdObstacle = SpeedRacerCustomImage(image:car)
            createdObstacle.imageTag = "car"
            let randomx = self.randomNumberbtnpoints(viewwidth:UInt32(Int32(gamewidth)))
            createdObstacle.frame = CGRect(x:Int(randomx), y: 0, width: (gamewidth / 12), height: (gameheight / 12))
        default:
            let coin = self.addCoins()
            createdObstacle = SpeedRacerCustomImage(image:coin)
            createdObstacle.imageTag = "coin"
            let randomx = self.randomNumberbtnpoints(viewwidth:UInt32(Int32(gamewidth)))
            createdObstacle.frame = CGRect(x:Int(randomx), y: 0, width: (gamewidth / 16), height: (gameheight / 16))
        }
        
        
        speedRacerBehaviour.addCar(collisionObstacle: createdObstacle)
        //score += 20
        
        //RESET THE TIMER FOR THE CAR USING RANDOM NUMBER
        let randomTimerInterval = arc4random_uniform(2)
        if(randomTimerInterval == 1){
            self.createCarObstacleTimer = Timer.scheduledTimer(timeInterval:0.5, target:self, selector: #selector(RacerMainController.addGameCars), userInfo:nil, repeats:true)
        }else {
            self.createCarObstacleTimer = Timer.scheduledTimer(timeInterval:0.08, target:self, selector: #selector(RacerMainController.addGameCars), userInfo:nil, repeats:true)
        }
        
      
    }
    
    
    
    //set behaviours function for adding behaviours
    
    func setBehaviours(){
        
        speedRaceDynamicAnimator = UIDynamicAnimator(referenceView:self.view)
        speedRacerBehaviour = SpeedRacerBehaviour(controller:self)
        speedRacerBehaviour.addCarCollision(barrierName: "mainCar", image: mainCar)
        speedRaceDynamicAnimator.addBehavior(speedRacerBehaviour)
        
    }
    
    
    
    
    func setScore(){
        self.scoreBoard?.text = "Score: \(self.score)"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScore()
        
        mainCar.frame = CGRect(x:Int(gamewidth/12),y:(gameheight-(gameheight/4)),width:(gamewidth/6),height:(gamewidth/6))
        
        self.createCarObstacleTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(RacerMainController.addGameCars), userInfo: nil, repeats:true)
        self.setBehaviours()
        
        setRoad()
        addGameCars()
        self.dispatchtofinishgame()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.dispatchtofinishgame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
