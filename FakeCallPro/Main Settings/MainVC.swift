//
//  MainVC.swift
//  FakeCallPro
//
//  Created by Ankit Saxena on 24/02/19.
//  Copyright © 2019 Ankit Saxena. All rights reserved.
//

import UIKit

class MainVC: UITableViewController {

    @IBOutlet var settingsTableView: UITableView!
    @IBOutlet weak var defTime: UILabel!
    @IBOutlet weak var defVoice: UILabel!
    @IBOutlet weak var defRing: UILabel!
    @IBOutlet weak var defName: UILabel!
    
    var soundPref : Bool = true
    var vibrationPref : Bool = true
    var dName = "mobile" //Default device name
    let device = UIDevice.current
    
//    var settingsArray = ["Time", "Caller", "Ring & Vibration", "Voice", "Wallpaper"]
//    var tempdefaultSettings = ["3 Seconds Later", "Ashish", "Opening", "Voice2", ""]
//    var defaultSettings = [String]()
//    let cellImage = ["time", "caller", "ringtone", "voice", "wallpaper"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        device.isProximityMonitoringEnabled = false
    }
    //MARK: TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentIndex = indexPath.row
        let currentSection = indexPath.section
        if currentSection == 0{
            
            if currentIndex == 0 {
                performSegue(withIdentifier: "timeSet", sender: self)
            }
            else if currentIndex == 1{
                performSegue(withIdentifier: "goToCaller", sender: self)
            }
            else if currentIndex == 2{
                performSegue(withIdentifier: "goToRing", sender: self)
            }
            else if currentIndex == 3{
                performSegue(withIdentifier: "goToVoice", sender: self)
            }
        }
        
        else if currentSection == 1{
            performSegue(withIdentifier: "goToBlack", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "timeSet"{
            let destinationVC = segue.destination as! TimeVC
            destinationVC.delegate = self
        }
        else if segue.identifier == "goToCaller"{
            let destinationVC = segue.destination as! CallerVC
            destinationVC.delegate = self
        }
        else if segue.identifier == "goToRing"{
            let destinationVC = segue.destination as! RingAndVibVC
            destinationVC.delegate = self
        }
        else if segue.identifier == "goToVoice"{
            let destinationVC = segue.destination as! SetVoice
            destinationVC.delegate = self
        }
        else if segue.identifier == "goToBlack"{
            let destinationVC = segue.destination as! BlackCallScreenVC
            destinationVC.time = defTime.text!
            destinationVC.receivedSettings = ["defCaller" : defName.text!, "defRing" : defRing.text!, "defVoice" : defVoice.text!, "eSound" : "\(soundPref)", "eVibration" : "\(vibrationPref)", "dName" : "\(dName)"]
        }
    }
    
    
}

extension MainVC : selectTimeDelegate, callerNameDelegate, SelectRingDelegate, selectVoiceDelegate {
    
    func timeSelected(sTime: String) {
        defTime.text = sTime
        settingsTableView.reloadData()
    }
    
    func callerName(cName: String, dName: String) {
        defName.text = cName
        self.dName = dName
        settingsTableView.reloadData()
    }
    
    func selectedRing(ring: String, eSound: Bool, eVibration: Bool) {
        defRing.text = ring
        self.soundPref = eSound
        self.vibrationPref = eVibration
        settingsTableView.reloadData()
    }
    
    func voiceSelected(sVoice: String) {
        defVoice.text = sVoice
        settingsTableView.reloadData()
    }
    
    
}

