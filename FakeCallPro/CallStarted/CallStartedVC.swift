//
//  CallStartedVC.swift
//  FakeCallPro
//
//  Created by Ankit Saxena on 03/03/19.
//  Copyright © 2019 Ankit Saxena. All rights reserved.
//

import UIKit

class CallStartedVC: UIViewController {

    @IBOutlet weak var callerName: UILabel!
    
    var receivedSettings : [String : String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let callerName = receivedSettings?["defCaller"]{
            getCallerLabel(cLabel: callerName)
        }
        else{
            callerName.text = "Ashish def"
        }
    }
    
    func getCallerLabel(cLabel: String) {
        callerName.text = cLabel
    }
    
    @IBAction func declineButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func acceptButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "callPicked", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "callPicked"{
            let destinationVC = segue.destination as! CallAcceptedVC
            destinationVC.receivedSettings = receivedSettings
        }
    }

}
