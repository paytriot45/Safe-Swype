//
//  RingAndVibVC.swift
//  FakeCallPro
//
//  Created by Ankit Saxena on 25/02/19.
//  Copyright © 2019 Ankit Saxena. All rights reserved.
//

import UIKit

protocol SelectRingDelegate {
    func selectedRing(ring : String)
}

class RingAndVibVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ringTableView: UITableView!
    var ringArray = ["Opening", "Reflection(for iPhone X)", "Marimba", "Xylophone", "Apex", "By The Seaside", "Piano Riff", "Sencha", "Silk", "Strum", "Time Passing", "Night Owl", "Old Phone"]
    var delegate : SelectRingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ringTableView.delegate = self
        ringTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ringArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ringCell", for: indexPath)
        cell.textLabel?.text = ringArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedRing(ring: ringArray[indexPath.row])
    }
    

}
