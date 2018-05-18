//
//  PassthruScrollView.swift
//  F1Project
//
//  Created by T1aluno09 on 17/05/18.
//  Copyright © 2018 T1aluno09. All rights reserved.
//

import UIKit

protocol PassthruScrollViewDelegate: class {
    func locationTouchedOnScreen(location: CGPoint)
}

class PassthruScrollView: UIScrollView {

    weak var passThruDelegate: PassthruScrollViewDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let view = superview {
            view.touchesBegan(touches, with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        let location = touches.first!.location(in: self)
        passThruDelegate?.locationTouchedOnScreen(location: location)
        
    }

}
