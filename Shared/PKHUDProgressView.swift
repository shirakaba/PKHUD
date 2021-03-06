//
//  PKHUDProgressVIew.swift
//  PKHUD
//
//  Created by Philip Kluz on 6/12/15.
//  Copyright (c) 2016 NSExceptional. All rights reserved.
//  Licensed under the MIT license.
//

#if os(iOS) || os(watchOS)
    import UIKit
#elseif os(OSX)
    import Cocoa
#endif

import QuartzCore

/// PKHUDProgressView provides an indeterminate progress view.
public class PKHUDProgressView: PKHUDSquareBaseView, PKHUDAnimating {
    
    public init(title: String? = nil, subtitle: String? = nil) {
        super.init(image: PKHUDAssets.progressActivityImage, title: title, subtitle: subtitle)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    func startAnimation() {
        let imageViewLayer: CALayer! = imageView.layer
        imageViewLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        imageViewLayer.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        imageViewLayer.addAnimation(PKHUDAnimation.discreteRotation, forKey: "progressAnimation")
    }
    
    func stopAnimation() {
    }
}
