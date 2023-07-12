//
//  ViewController.swift
//  CatchTheJohnnyGames
//
//  Created by uludağ on 3.07.2023.
//

import UIKit

class ViewController: UIViewController {

    // Variable
    var score = 0
    var timer = Timer()
    var counter = 0
    var johnnyArray = [UIImageView]()
    var hideTimer = Timer()
    var hightScore = 0
    
    // Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var hightscoreLabel: UILabel!
    @IBOutlet weak var johnny1: UIImageView!
    @IBOutlet weak var johnny2: UIImageView!
    @IBOutlet weak var johnny3: UIImageView!
    @IBOutlet weak var johnny4: UIImageView!
    @IBOutlet weak var johnny5: UIImageView!
    @IBOutlet weak var johnny6: UIImageView!
    @IBOutlet weak var johnny7: UIImageView!
    @IBOutlet weak var johnny8: UIImageView!
    @IBOutlet weak var johnny9: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score : \(score)"
        
        // Hightscore Check
        let storedHigtScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHigtScore == nil {
            hightScore = 0
            hightscoreLabel.text = "HightScore : \(hightScore)"
        }
        
        if let  newScore = storedHigtScore as? Int {
            hightScore = newScore
            hightscoreLabel.text = "HightScore : \(hightScore)"
        }
        
        
        // İmages
        johnny1.isUserInteractionEnabled = true
        johnny2.isUserInteractionEnabled = true
        johnny3.isUserInteractionEnabled = true
        johnny4.isUserInteractionEnabled = true
        johnny5.isUserInteractionEnabled = true
        johnny6.isUserInteractionEnabled = true
        johnny7.isUserInteractionEnabled = true
        johnny8.isUserInteractionEnabled = true
        johnny9.isUserInteractionEnabled = true
        
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        johnny1.addGestureRecognizer(recognizer1)
        johnny2.addGestureRecognizer(recognizer2)
        johnny3.addGestureRecognizer(recognizer3)
        johnny4.addGestureRecognizer(recognizer4)
        johnny5.addGestureRecognizer(recognizer5)
        johnny6.addGestureRecognizer(recognizer6)
        johnny7.addGestureRecognizer(recognizer7)
        johnny8.addGestureRecognizer(recognizer8)
        johnny9.addGestureRecognizer(recognizer9)
        
        johnnyArray = [johnny1,johnny2,johnny3,johnny4,johnny5,johnny6,johnny7,johnny8,johnny9]
        
        
        //Timers
        counter = 10
        timeLabel.text = String(counter)
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideJohnny), userInfo: nil, repeats: true)
        
        
        hideJohnny()
    }
    
   @objc func hideJohnny(){
        for johnny in johnnyArray {
            johnny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(johnnyArray.count - 1)))
        johnnyArray[random].isHidden = false
    }
    
    
    

    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score : \(score  )"
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            
            for johnny in johnnyArray {
                johnny.isHidden = true
            }
            
            // HightScore
            if self.score > self.hightScore {
                self.hightScore = self.score
                hightscoreLabel.text = "HightScore : \(self.hightScore)"
                UserDefaults.standard.set(self.hightScore, forKey: "highscore")
            }
            
            
            // Alert
            
            let alert = UIAlertController(title: "Time s Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { [self] UIAlertAction in
                // Replay function
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideJohnny), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replay)
            self.present(alert, animated: true )
            
            
            
        }
    }

}

