//
//  RacerMainController.swift
//  SpeedRacerV2
//
//  Created by Solomon Bbaale on 24/03/2018.
//  Copyright © 2018 com.EngineersParadise. All rights reserved.
//

import UIKit
import AVFoundation

class RacerMainController: UIViewController {

    
    var road = [UIImage]()
    
    //main controller images
    @IBOutlet var mainRoad: UIImageView!
    
    @IBOutlet weak var mainCar: MovableUIIMageView!
    
    @IBOutlet weak var coinBoard: UILabel!
    
    @IBOutlet weak var scoreBoard: UILabel!
    
    @IBOutlet weak var countDown: UIImageView!
    //Score stuff
    var score = 0
    var coins = 0
    var noofofaccidents = 0
    var explosion = "explosion.png"
    
    
    //other variables
    
    let ImagesLocation = "images/"
    var gamewidth = Int(UIScreen.main.bounds.width)
    var gameheight = Int(UIScreen.main.bounds.height)
    var timer:Timer = Timer()
    var soundTimer:Timer = Timer()
    var maincarimage = "car0.png"
    
    var delayBeforeGameEnds = DispatchTime.now() + 20
    var createCarObstacleTimer:Timer = Timer()
    var finishviewloaded:Bool = false
    var countdowntimer:Timer = Timer()
    public var gameended = false
    
    //countdown for racing
    var countdownfinished = 0
    
    
    //sounds for game
    
    var gamePlayer:AVAudioPlayer? = nil
    var coinPlayer:AVAudioPlayer? = nil
    
    
    //behaviour configuration
    var speedRaceDynamicAnimator:UIDynamicAnimator!
    var speedRacerBehaviour:SpeedRacerBehaviour! = nil
    
    
    //setting up finishgame strategy
    @objc func dispatchtofinishgame(){
        
        DispatchQueue.main.asyncAfter(deadline: delayBeforeGameEnds){
      //  self.gamePlayer?.play()
        self.performSegue(withIdentifier: "moveToFinish", sender: self)
          
        self.soundTimer.invalidate()
        self.gameended = true
        self.gamePlayer?.stop()
        self.coinPlayer?.stop()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        setScore()
        if(segue.identifier == "moveToFinish"){
            
            
            let topscore = UserDefaults.standard.object(forKey: "topscore")
            if (self.score > topscore as! Int){
                UserDefaults.standard.set(self.score, forKey:"topscore")
            }
            
            let destinationViewController = segue.destination as! EndViewController
            destinationViewController.endscore = self.score
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
        //1...20
        for roadindex in 1...20{
            //road\(roadindex).png
            let currentroad = "road\(roadindex).png"
            let roadimage = UIImage(named:currentroad)
            road.append(roadimage!)
        }
        mainRoad.image = UIImage.animatedImage(with:road, duration: 0.1)
        
    }
    
    
    //functions to add cars to game
    func gameCars()->[UIImage]{
        
        var cars = [UIImage]()
        //0...6
        for carindex in 0...6{
        
            //let car = UIImage(named:"car\(carindex).png")!
            let carname = "car\(carindex).png"
            let car = UIImage(named:carname)!
            
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
    
    
    func randombtnRange(_ range:Range<Int>) -> Int {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    

    
    
    @objc func addGameCars(){
        self.createCarObstacleTimer.invalidate();
        //var cars = createCars()
        
        let randomnumber = arc4random_uniform(7)
        
        var createdObstacle:SpeedRacerCustomImage!
        
        let randx = self.randombtnRange((gamewidth / 7)..<(gamewidth - (gamewidth / 5)))

        switch randomnumber {
        case 0,2,3,5,6,7:
            let car = self.createCar()
            createdObstacle = SpeedRacerCustomImage(image:car)
            createdObstacle.imageTag = "car"
            
            
            createdObstacle.frame = CGRect(x:Int(randx), y: 0, width: (gamewidth / 12), height: (gameheight / 12))
        default:
            let coin = self.addCoins()
            createdObstacle = SpeedRacerCustomImage(image:coin)
            createdObstacle.imageTag = "coin"
            createdObstacle.frame = CGRect(x:Int(randx), y: 0, width: (gamewidth / 20), height: (gameheight / 20))
        }
        
        
        speedRacerBehaviour.addCar(collisionObstacle: createdObstacle)
        if(!self.gameended){
        self.score += 10
        }
        //RESET THE TIMER FOR THE CAR USING RANDOM NUMBER
        let randomTimerInterval = arc4random_uniform(2)
        if(randomTimerInterval == 1){
            self.createCarObstacleTimer = Timer.scheduledTimer(timeInterval:1, target:self, selector: #selector(RacerMainController.addGameCars), userInfo:nil, repeats:true)
        }else {
            //0.009
            self.createCarObstacleTimer = Timer.scheduledTimer(timeInterval:1.3, target:self, selector: #selector(RacerMainController.addGameCars), userInfo:nil, repeats:true)
        }
        self.scoreBoard?.text = " \(self.score)"
        speedRacerBehaviour?.removeOutOfBoundsSubViews()
      
    }
    
    
    
    //set behaviours function for adding behaviours
    
    func setBehaviours(){
        
        speedRaceDynamicAnimator = UIDynamicAnimator(referenceView:self.view)
        speedRacerBehaviour = SpeedRacerBehaviour(controller:self)
        speedRacerBehaviour.addCarCollision(barrierName: "mainCar", image: mainCar)
        speedRaceDynamicAnimator.addBehavior(speedRacerBehaviour)
        
    }
    
    
    
    
    func setScore(){
        
        self.scoreBoard?.text = " \(self.score)"
        self.coinBoard?.text = "\(self.coins)"
    }
    
    
    func soundLoader(filename: String) -> AVAudioPlayer {
        
        var player = AVAudioPlayer()
        let path = Bundle.main.path(forResource:filename, ofType:nil)!
        let url = URL(fileURLWithPath: path)
    
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
        } catch let error {
            print("Error loading \(String(describing: url)): \(error.localizedDescription)")
        }
        return player
    }
    @objc func playSound1(){
        self.gamePlayer?.volume = 3.5
        self.gamePlayer?.play()
    }
    
    
    func playSound(){
        self.gamePlayer = soundLoader(filename:"Race-car-sounds.mp3")
        soundTimer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(RacerMainController.playSound1), userInfo: nil, repeats: true)
        timer.fire()
        
    }
    func playCoinSound(){
        self.coinPlayer = soundLoader(filename: "Mario-coin-sound.mp3")
        self.coinPlayer?.play()
    }
    
    
    @IBOutlet weak var coinsText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scoreBoard.textAlignment = .right
        setScore()
        self.setBehaviours()
        mainCar.frame = CGRect(x:Int(gamewidth/12),y:(gameheight-(gameheight/4)),width:(gamewidth/6),height:(gamewidth/6))

        setRoad()
        addGameCars()
        self.dispatchtofinishgame()
        playSound()
        
        if(UserDefaults.standard.object(forKey:"topscore") == nil){
            UserDefaults.standard.set(0, forKey: "topscore")
        }
        
        
        
        //mainCar.frame = CGRect(x:Int(gamewidth/12),y:(gameheight-(gameheight/4)),width:(gamewidth/6),height:(gamewidth/6))
        
        self.createCarObstacleTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(RacerMainController.addGameCars), userInfo: nil, repeats:true)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        self.dispatchtofinishgame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
