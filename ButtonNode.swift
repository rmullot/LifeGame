//
//  ButtonNode.swift
//  LifeGame
//
//  Created by Romain Mullot on 13/03/2018.
//  Copyright © 2018 Apportable. All rights reserved.
//

import SpriteKit

enum ButtonNodeState {
    case buttonNodeStateActive, buttonNodeStateSelected, buttonNodeStateHidden
}

class ButtonNode: SKSpriteNode {
    
    /* Setup a dummy action closure */
    var selectedHandler: () -> Void = { print("No button action set") }
    
    /* Button state management */
    var state: ButtonNodeState = .buttonNodeStateActive {
        didSet {
            switch state {
            case .buttonNodeStateActive:
                /* Enable touch */
                self.isUserInteractionEnabled = true
                
                /* Visible */
                self.alpha = 1
                break
            case .buttonNodeStateSelected:
                /* Semi transparent */
                self.alpha = 0.7
                break
            case .buttonNodeStateHidden:
                /* Disable touch */
                self.isUserInteractionEnabled = false
                
                /* Hide */
                self.alpha = 0
                break
            }
        }
    }
    
    /* Support for NSKeyedArchiver (loading objects from SK Scene Editor */
    required init?(coder aDecoder: NSCoder) {
        
        /* Call parent initializer e.g. SKSpriteNode */
        super.init(coder: aDecoder)
        
        /* Enable touch on button node */
        self.isUserInteractionEnabled = true
    }
    
    // MARK: - Touch handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        state = .buttonNodeStateSelected
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedHandler()
        state = .buttonNodeStateActive
    }
    
}

