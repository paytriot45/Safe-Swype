//
//  CallAcceptedVC.swift
//  FakeCallPro
//
//  Created by Ankit Saxena on 05/03/19.
//  Copyright © 2019 Ankit Saxena. All rights reserved.
//
// CallAcceptedVC.swift
import UIKit
import AVFoundation

class CallAcceptedVC: UIViewController {

    @IBOutlet weak var callerNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var seconds: Int = 0
    var minutes: Int = 0
    var timer: Timer!
    var secText = "", minText = ""
    var selectedVoice = "voice1"
    
    var receivedSettings: [String: String]?
    var buttonPressedCount = 0
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectVoice()
        playSound()
        let device = UIDevice.current
        device.isProximityMonitoringEnabled = true
        setCallerName()
        
        secText = String(format: "%02d", seconds)
        minText = String(format: "%02d", minutes)
        timeLabel.text = "\(minText) : \(secText)"
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            self.updateSec()
        })
    }
    
    func selectVoice() {
        if let receivedVoice = receivedSettings?["defVoice"] {
            selectedVoice = receivedVoice
        }
    }
    
    func playSound() {
        print("Selected Voice is \(selectedVoice)")
        guard let soundURL = Bundle.main.url(forResource: "\(selectedVoice.lowercased())", withExtension: "mp3") else {
            print("Sound file not found.")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default)
            audioPlayer.play()
        } catch {
            print("Error playing sound: \(error)")
        }
    }
    
    func setCallerName() {
        if let callerName = receivedSettings?["defCaller"] {
            callerNameLabel.text = callerName
        } else {
            callerNameLabel.text = "Unknown Caller"
        }
    }

    func updateSec() {
        seconds += 1
        if seconds > 59 {
            seconds = 0
            updateMins()
        }
        secText = String(format: "%02d", seconds)
        timeLabel.text = "\(minText) : \(secText)"
    }
    
    func updateMins() {
        minutes += 1
        if minutes > 59 {
            minutes = 0
        }
        minText = String(format: "%02d", minutes)
        timeLabel.text = "\(minText) : \(secText)"
    }

    @IBAction func endButtonPressed(_ sender: UIButton) {
        buttonPressedCount += 1
        timer.invalidate()
        timeLabel.text = "Call ended"
        if buttonPressedCount == 1 {
            callEnd(with: 2)
        } else {
            callEnd()
        }
    }
    
    func callEnd(with wTime: Double = 0) {
        timer = Timer.scheduledTimer(withTimeInterval: wTime, repeats: false, block: { (Timer) in
            print("Call ended")
            self.buttonPressedCount = 0
            UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
        })
    }
}
