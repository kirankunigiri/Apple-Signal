//
//  ViewController.swift
//  Family
//
//  Created by Kiran Kunigiri on 12/16/16.
//  Copyright © 2016 Kiran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var devicesLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: Properties
    let signal = Signal(serviceType: "signal-demo")
    
    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = ""
        textField.delegate = self
        textField.returnKeyType = .done
        
        signal.delegate = self
    }

    // MARK: Methods
    @IBAction func autoConnect(_ sender: UIButton) {
        signal.autoConnect()
    }
    
    @IBAction func inviteAuto(_ sender: UIButton) {
        signal.inviteAuto()
    }
    
    @IBAction func inviteUI(_ sender: UIButton) {
        let vc = signal.inviteUI()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func acceptAuto(_ sender: UIButton) {
        signal.acceptAuto()
    }
    
    @IBAction func acceptUI(_ sender: UIButton) {
        signal.acceptUI()
    }
    
    @IBAction func stopSearching(_ sender: UIButton) {
        signal.stopSearching()
    }
    
    @IBAction func disconnect(_ sender: UIButton) {
        signal.disconnect()
    }
    
    @IBAction func shutDown(_ sender: UIButton) {
        signal.shutDown()
    }

}



// MARK: - Text field delegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textLabel.text = textField.text
        if (textField.text != nil && textField.text!.characters.count > 0) {
            signal.sendData(object: textField.text!, type: DataType.string.rawValue)
        }
        textField.resignFirstResponder()
        return false
    }
}



// MARK: - Family delegate
extension ViewController: SignalDelegate {
    
    func receivedData(data: Data, type: UInt) {
        OperationQueue.main.addOperation {
            let string = data.convert() as? String
            self.textLabel.text = string
        }
    }
    
    func receivedInvitation(device: String, alert: UIAlertController?) {
        if (signal.acceptMode == .UI) {
            self.present(alert!, animated: true, completion: nil)
        }
    }
    
    func deviceConnectionsChanged(connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            if (connectedDevices.count > 0) {
                self.devicesLabel.text = "Connected Devices: \(connectedDevices)"
            } else {
                self.devicesLabel.text = "No devices conncted"
            }
        }
    }
    
}
