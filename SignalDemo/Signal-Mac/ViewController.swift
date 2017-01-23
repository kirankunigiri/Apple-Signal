//
//  ViewController.swift
//  FamilyDemo-Mac
//
//  Created by Kiran Kunigiri on 12/22/16.
//  Copyright © 2016 Kiran. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    // MARK: IBOutlets
    @IBOutlet weak var textLabel: NSTextField!
    @IBOutlet weak var deviceLabel: NSTextField!
    @IBOutlet weak var textField: NSTextField!
    
    // MARK: Properties
    let signal = Signal.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signal.initialize(serviceType: "signal-demo")
        signal.delegate = self
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func textFieldAction(_ sender: NSTextField) {
        self.textLabel.stringValue = sender.stringValue
        if (textField.stringValue.characters.count > 0) {
            signal.sendObject(object: textField.stringValue, type: DataType.string.rawValue)
        }
    }
    
    @IBAction func connect(_ sender: NSButton) {
        signal.autoConnect()
    }
    
    @IBAction func stopSearching(_ sender: NSButton) {
        signal.stopSearching()
    }
    
    @IBAction func disconnect(_ sender: NSButton) {
        signal.disconnect()
    }
    
    @IBAction func shutDown(_ sender: NSButton) {
        signal.shutDown()
    }

}



extension ViewController: SignalDelegate {
    
    func signal(_ signal: Signal, didReceiveData data: Data, ofType type: UInt32) {
        let string = data.convert() as! String
        self.textLabel.stringValue = string
    }
    
    func signal(_ signal: Signal, shouldAcceptInvitationFrom device: String, respond: @escaping (Bool) -> Void) {
        respond(true)
    }
    
    func signal(_ signal: Signal, connectedDevicesChanged devices: [String]) {
        if (devices.count > 0) {
            self.deviceLabel.stringValue = "Connected Devices: \(devices)"
        } else {
            self.deviceLabel.stringValue = "No devices conncted"
        }
    }
    
}
