//
//  PKHUDCheckmarkView.swift
//  PKHUD
//
//  Created by Philip Kluz on 9/27/15.
//  Copyright (c) 2016 NSExceptional. All rights reserved.
//  Licensed under the MIT license.
//

#if os(iOS) || os(watchOS)
    import UIKit
#elseif os(OSX)
    import Cocoa
#endif

/// PKHUDCheckmarkView provides an animated success (checkmark) view.
public class PKHUDSuccessView: PKHUDSquareBaseView, PKHUDAnimating {
    
    var checkmarkShapeLayer: CAShapeLayer = {
        let checkmarkPath = BezierPath()
        checkmarkPath.moveToPoint(CGPointMake(4.0, 27.0))
        
        #if os(iOS) || os(watchOS)
        checkmarkPath.addLineToPoint(CGPointMake(34.0, 56.0))
        checkmarkPath.addLineToPoint(CGPointMake(88.0, 0.0))
        #elseif os(OSX)
        checkmarkPath.lineToPoint(CGPointMake(34.0, 56.0))
        checkmarkPath.lineToPoint(CGPointMake(88.0, 0.0))
        #endif
        
        let layer = CAShapeLayer()
        layer.frame = CGRectMake(3.0, 3.0, 88.0, 56.0)
        layer.path = checkmarkPath.CGPath
        layer.fillMode = kCAFillModeForwards
        layer.lineCap     = kCALineCapRound
        layer.lineJoin    = kCALineJoinRound
        layer.fillColor   = nil
        layer.strokeColor = Color(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0).CGColor
        layer.lineWidth   = 6.0
        return layer
    }()
    
    public init(title: String? = nil, subtitle: String? = nil) {
        super.init(title: title, subtitle: subtitle)
        commonInit()
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override func commonInit() {
        #if os(OSX)
            self.wantsLayer = true  // NSView will create a CALayer automatically
        #endif

        let layer: CALayer! = self.layer

        layer.addSublayer(checkmarkShapeLayer)
        checkmarkShapeLayer.position = CGPoint(x: layer.frame.width/2, y: layer.frame.height/2)
    }
    
    public func startAnimation() {
        let checkmarkStrokeAnimation = CAKeyframeAnimation(keyPath:"strokeEnd")
        checkmarkStrokeAnimation.values = [0, 1]
        checkmarkStrokeAnimation.keyTimes = [0, 1]
        checkmarkStrokeAnimation.duration = 0.35
        
        checkmarkShapeLayer.addAnimation(checkmarkStrokeAnimation, forKey:"checkmarkStrokeAnim")
    }
    
    public func stopAnimation() {
        checkmarkShapeLayer.removeAnimationForKey("checkmarkStrokeAnimation")
    }
}
