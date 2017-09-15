//
//  ViewController.swift
//  MouseMover
//
//  Created by Hosk, Johan on 2017-09-14.
//  Copyright © 2017 Wirecard. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, KeyPressDelegate {

    @IBOutlet weak var label: NSTextField!
    
    var keyPress:KeyPress!
    var isMovingMouse = false
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyPress = KeyPress(delegate: self)
        self.view.addSubview(keyPress)
        self.nextResponder = keyPress
        label.stringValue = "Press S to start automatically moving the mouse"
    }
    
    func didPressSKey() {
        toggleMovingMouse()
    }

    func toggleMovingMouse() {
        if isMovingMouse {
            stopMovingMouse()
        }else {
            startMovingMouse()
        }
    }
    
    func stopMovingMouse() {
        isMovingMouse = false
        print("Stopped moving mouse")
        label.stringValue = "Press S to start automatically moving the mouse"
        timer?.invalidate()
    }
    
    func startMovingMouse() {
        isMovingMouse = true
        print("Started moving mouse")
        label.stringValue = "Press S to stop automatically moving the mouse"

        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.keepActive), userInfo: nil, repeats: true)
    }
    
    func keepActive() {
        moveMouseToRandomScreenPosition()
        triggerCommand()
    }
    
    func triggerCommand() {
        let src = CGEventSource(stateID: CGEventSourceStateID.hidSystemState)

        let cmdd = CGEvent(keyboardEventSource: src, virtualKey: 0x38, keyDown: true)
        let cmdu = CGEvent(keyboardEventSource: src, virtualKey: 0x38, keyDown: false)
        let spcd = CGEvent(keyboardEventSource: src, virtualKey: 0x31, keyDown: true)
        let spcu = CGEvent(keyboardEventSource: src, virtualKey: 0x31, keyDown: false)
        
        spcd?.flags = CGEventFlags.maskCommand;
        
        let loc = CGEventTapLocation.cghidEventTap
        
        cmdd?.post(tap: loc)
        spcd?.post(tap: loc)
        spcu?.post(tap: loc)
        cmdu?.post(tap: loc)
    }
    
    func moveMouseToRandomScreenPosition() {
        var mouseLoc = NSEvent.mouseLocation()
        let screenWidth = NSHeight(NSScreen.screens()![0].frame)
        let randomPercent = CGFloat(arc4random_uniform(100)) / 100
        mouseLoc.x = screenWidth * randomPercent
        CGDisplayMoveCursorToPoint(0, CGPoint(x: mouseLoc.x, y: mouseLoc.y))
    }
    
    deinit {
        stopMovingMouse()
    }
}

