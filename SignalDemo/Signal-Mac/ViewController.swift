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
    let signal = Signal(serviceType: "signal-demo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            signal.sendData(object: textField.stringValue, type: DataType.string.rawValue)
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
    
    func receivedData(data: Data, type: UInt) {
        OperationQueue.main.addOperation {
            let string = data.convert() as! String
            print(type)
            
            self.textLabel.stringValue = string
        }
    }
    
    func receivedInvitation(device: String) {
        
    }
    
    func deviceConnectionsChanged(connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            if (connectedDevices.count > 0) {
                self.deviceLabel.stringValue = "Connected Devices: \(connectedDevices)"
            } else {
                self.deviceLabel.stringValue = "No devices conncted"
            }
        }
    }
}
