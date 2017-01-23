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
    let signal = Signal.instance
    
    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = ""
        textField.delegate = self
        textField.returnKeyType = .done
        
        signal.initialize(serviceType: "signal-demo")
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
        signal.inviteUI()
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
            signal.sendObject(object: textField.text!, type: DataType.string.rawValue)
        }
        textField.resignFirstResponder()
        return false
    }
}



// MARK: - Family delegate
extension ViewController: SignalDelegate {
    
    func signal(didReceiveData data: Data, ofType type: UInt32) {
        let string = data.convert() as! String
        self.textLabel.text = string
    }
    
    func signal(connectedDevicesChanged devices: [String]) {
        if (devices.count > 0) {
            self.devicesLabel.text = "Connected Devices: \(devices)"
        } else {
            self.devicesLabel.text = "No devices connected"
        }
    }
    
}



