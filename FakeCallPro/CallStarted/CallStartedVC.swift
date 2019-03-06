//
//  CallStartedVC.swift
//  FakeCallPro
//
//  Created by Ankit Saxena on 03/03/19.
//  Copyright © 2019 Ankit Saxena. All rights reserved.
//

import UIKit
import AVFoundation

class CallStartedVC: UIViewController {

    @IBOutlet weak var callerName: UILabel!
    
    var receivedSettings : [String : String]?
    var audioPlayer : AVAudioPlayer!
    var ring = "Opening"
    var timer : Timer!
    var enableSound  = true
    var enableVibration = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Vibration is \(enableVibration)")
        checkCallerName()
        checkVibrationAndSound()
        playSound()
    }
    
    func checkCallerName(){
        if let callerName = receivedSettings?["defCaller"]{
            getCallerLabel(cLabel: callerName)
            ring = receivedSettings?["defRing"] ?? "Opening"
        }
        else{
            callerName.text = "Ashish def"
        }
    }
    
    func checkVibrationAndSound(){
         print("Vibration is \(enableVibration)")
        if receivedSettings!["eVibration"] == "false"{
            enableVibration = false
        }
        else if receivedSettings!["eSound"] == "false"{
            enableSound = false
        }
    }
    
    func playSoundVibration(){
         print("Vibration is \(enableVibration)")
        if enableSound == true{
            audioPlayer.play()
        }
        if enableVibration == true{
            print("enabling Vibration!")
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }
    
    //MARK: Playoing Sound Function
    func playSound(){
        let soundURl = Bundle.main.url(forResource: ring, withExtension: "mp3")
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: soundURl!)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
        }
            
        catch{
            print(error)
        }
         print("Vibration is \(enableVibration)")
        //Playing Audio
        playSoundVibration()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            self.playSoundVibration()
        }
        
    }
    
    
    //MARK: Call Accept and Decline Funtions
    
    func getCallerLabel(cLabel: String) {
        callerName.text = cLabel
    }
    
    @IBAction func declineButtonPressed(_ sender: UIButton) {
        audioPlayer.stop()
        timer.invalidate()
        UIControl().sendAction(#selector(NSXPCConnection.suspend),
                               to: UIApplication.shared, for: nil)
        self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func acceptButtonPressed(_ sender: UIButton) {
        audioPlayer.stop()
        timer.invalidate()
        performSegue(withIdentifier: "callPicked", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "callPicked"{
            let destinationVC = segue.destination as! CallAcceptedVC
            destinationVC.receivedSettings = receivedSettings
        }
    }

}
