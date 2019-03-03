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
    
    var cName : String? = "Ashish"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callerName.text = cName

        // Do any additional setup after loading the view.
    }
    
    func getCallerLabel(cLabel: String) {
        callerName.text = cLabel
    }
    
    @IBAction func declineButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func acceptButtonPressed(_ sender: UIButton) {
    }
    
    

}
