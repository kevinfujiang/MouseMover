//
//  KeyPress.swift
//  MouseMover
//
//  Created by Hosk, Johan on 2017-09-14.
//  Copyright © 2017 Wirecard. All rights reserved.
//

import Cocoa

let sKey = 1

protocol KeyPressDelegate {
    func didPressSKey()
}

class KeyPress: NSView {
    
    var delegate : KeyPressDelegate?
    
    convenience init(delegate: KeyPressDelegate) {
        self.init(frame: CGRect.zero)
        self.delegate = delegate
    }
    
    override func keyUp(with event: NSEvent) {
        let character = Int(event.keyCode)
        if character == 1 {
            delegate?.didPressSKey()
        }
    }
    
    override var acceptsFirstResponder : Bool {
        return true
    }
}
