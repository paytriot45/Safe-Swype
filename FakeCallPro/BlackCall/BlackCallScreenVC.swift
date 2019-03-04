//
//  BlackCallScreenVC.swift
//  FakeCallPro
//
//  Created by Ankit Saxena on 05/03/19.
//  Copyright © 2019 Ankit Saxena. All rights reserved.
//

import UIKit

class BlackCallScreenVC: UIViewController {
    
    var receivedSettings : [String : String]?
    var time = ""
    var timeInDouble = 0.0
    var timer : Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        timeInDouble = timeDouble()
        timer = Timer.scheduledTimer(withTimeInterval: timeInDouble, repeats: false, block: { (Timer) in
        self.performSegue(withIdentifier: "startCall", sender: self)
        })
    }
    

    
    func timeDouble() -> Double{
        if time == "3 Seconds Later"{
            return 3
        }
            
        else if time == "10 Seconds Later"{
            return 10
        }
            
        else if time == "30 Seconds Later"{
            return 30
        }
            
        else if time == "1 Minute Later"{
            return 60
        }
            
        else if time == "2 Minutes Later"{
            return 120
        }
        else {
            return 300
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startCall"{
            let destinationVC = segue.destination as! CallStartedVC
            destinationVC.receivedSettings = receivedSettings
        }
    }


}
