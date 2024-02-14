// CallStartedVC.swift
import UIKit
import AVFoundation

class CallStartedVC: UIViewController {

    @IBOutlet weak var callerName: UILabel!
    @IBOutlet weak var deviceName: UILabel!
    
    var receivedSettings: [String: String]?
    var audioPlayer: AVAudioPlayer?
    var ring = "Opening"
    var timer: Timer?
    var enableSound = true
    var enableVibration = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkCallerName()
        checkVibrationAndSound()
        playSound()
    }
    
    func checkCallerName() {
        if let callerName = receivedSettings?["defCaller"] {
            getCallerLabel(cLabel: callerName)
            ring = receivedSettings?["defRing"] ?? "Opening"
        } else {
            callerName.text = "Mom"  // Updated default caller name
        }
    }
    
    func checkVibrationAndSound() {
        enableVibration = receivedSettings?["eVibration"] != "false"
        enableSound = receivedSettings?["eSound"] != "false"
    }
    
    func playSoundVibration() {
        if enableSound {
            audioPlayer?.play()
        }
        if enableVibration {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }
    
    // MARK: Playing Sound Function
    func playSound() {
        if let soundURL = Bundle.main.url(forResource: ring, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
            } catch {
                print("Error playing sound: \(error)")
            }
        }
        playSoundVibration()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.playSoundVibration()
        }
    }
    
    func getCallerLabel(cLabel: String) {
        callerName.text = cLabel
        deviceName.text = receivedSettings?["dName"]
    }
    
    // MARK: Call Accept and Decline Functions
    
    @IBAction func declineButtonPressed(_ sender: UIButton) {
        cleanupAudioAndTimer()
        UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
        self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func acceptButtonPressed(_ sender: UIButton) {
        cleanupAudioAndTimer()
        performSegue(withIdentifier: "callPicked", sender: self)
    }
    
    private func cleanupAudioAndTimer() {
        audioPlayer?.stop()
        timer?.invalidate()
    }
    
    // Sending Default Settings to the next Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "callPicked",
           let destinationVC = segue.destination as? CallAcceptedVC {
            destinationVC.receivedSettings = receivedSettings
        }
    }
}
