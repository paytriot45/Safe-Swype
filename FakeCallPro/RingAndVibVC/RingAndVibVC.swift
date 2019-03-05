//
//  RingAndVibVC.swift
//  FakeCallPro
//
//  Created by Ankit Saxena on 25/02/19.
//  Copyright © 2019 Ankit Saxena. All rights reserved.
//

import UIKit

protocol SelectRingDelegate {
    func selectedRing(ring : String, eSound : Bool, eVibration : Bool)
}

class RingAndVibVC: UITableViewController {

    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var vibrationSwitch: UISwitch!
    
    var ringArray = ["Opening", "Reflection", "Marimba", "Xylophone", "Apex", "By The Seaside", "Piano Riff", "Sencha", "Silk", "Strum", "Time Passing", "Night Owl", "Old Phone"]

    var delegate : SelectRingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedRing(ring: ringArray[indexPath.row], eSound: soundSwitch.isOn, eVibration: vibrationSwitch.isOn)
    }
}
