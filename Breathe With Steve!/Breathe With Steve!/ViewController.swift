//
//  ViewController.swift
//  Breathe With Steve!
//
//  Created by Sam on 12/16/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var time = 0
    var timer = Timer()
    var isOn = false
    var note = "MC1"
    var chosen = 10
    
    var audioPlayer = AVAudioPlayer()

    @IBOutlet weak var breatheButton: UIButton!
    
    @IBOutlet weak var landBackground: UIImageView!
    
    
    @IBOutlet weak var Slider: UISlider!
    
    @IBOutlet weak var displayTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: note, ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        } catch {
            print("error")
        }

    }

    @IBAction func Play(_ sender: Any){
        audioPlayer.play()

    }
    @IBOutlet weak var EndSound: UILabel!
    
    @objc func timeUp(){
        if (time == (chosen*60)){
            isOn = false
            note = "LF4"
            breatheButton.setTitle("Breathe!", for: .normal)
            timer.invalidate()
            time = 0
            displayTime.text = String(chosen) + " Minutes Meditated!"
        }else{
            time += 1
            displayTime.text = String(time) + " Seconds In!"
        }
    }

    @IBAction func breatheButton(_ sender: Any) {
        if (isOn == false){
            isOn = true
            breatheButton.setTitle("Pause!", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timeUp), userInfo: nil, repeats: true)
        }else{
            isOn = false
            breatheButton.setTitle("Breathe!", for: .normal)
            timer.invalidate()
            time = 0
            displayTime.text = "Minutes?"
        }

    }
    
    @IBAction func slideTimer(_ sender: UISlider) {
        displayTime.text = String(Int(sender.value)) + " Minutes Please!"
        chosen = Int(sender.value)
    }
    

}

