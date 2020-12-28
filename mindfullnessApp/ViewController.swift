//
//  ViewController.swift
//  mindfullnessApp
//
//  Created by Kenta on 2020/12/28.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    
    let meisouTime = ["見習い":300,"初心者":600,"中級者":900,"上級者":1200,"仙人":1800]
    
    var timer = Timer()
    var secondsPassed = 0
    var totalTime = 0
    var player: AVAudioPlayer?
     
    @IBAction func countButton(_ sender: UIButton) {
        
        timer.invalidate()
        let mode = sender.currentTitle!
        totalTime = meisouTime[mode]!
        modeLabel.text = "\(mode)モード"
        
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 ) {
            sender.alpha = 1.0
        }
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        }
    
    @objc func updateCounter() {
        
        if secondsPassed < totalTime {
            secondsPassed += 1
            countLabel.text = String("残り\(totalTime - secondsPassed)秒")
        } else {
            countLabel.text = "終了！お疲れ様でした。"
            
            func playSound() {
                guard let url = Bundle.main.url(forResource: "Alerm", withExtension: "mp3") else { return }

                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    
                    player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                    guard let player = player else { return }

                    player.play()

                } catch let error {
                    print(error.localizedDescription)
                }
            }
            playSound()
        }
    }
}


