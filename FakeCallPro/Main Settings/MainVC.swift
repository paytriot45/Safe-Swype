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
    
    
    var settingsArray = ["Time", "Caller", "Ring & Vibration", "Voice", "Wallpaper"]
    var tempdefaultSettings = ["3 Seconds Later", "Ashish", "Opening", "Voice2", ""]
    var defaultSettings = [String]()
    let cellImage = ["time", "caller", "ringtone", "voice", "wallpaper"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            performSegue(withIdentifier: "startCall", sender: self)
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
        else if segue.identifier == "startCall"{
            let destinationVC = segue.destination as! CallStartedVC
            destinationVC.cName = defName.text!
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
        settingsTableView.reloadData()
    }
    
    func selectedRing(ring: String) {
        defRing.text = ring
        settingsTableView.reloadData()
    }
    
    func voiceSelected(sVoice: String) {
        defVoice.text = sVoice
        settingsTableView.reloadData()
    }
    
    
}

