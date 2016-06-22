//
//  HUDView.swift
//  PKHUD
//
//  Created by Philip Kluz on 6/16/14.
//  Copyright (c) 2016 NSExceptional. All rights reserved.
//  Licensed under the MIT license.
//

#if os(iOS) || os(watchOS)
    import UIKit
#elseif os(OSX)
    import Cocoa
#endif

/// Provides the general look and feel of the PKHUD, into which the eventual content is inserted.
internal class FrameView: VisualEffectView {
    
    #if os(OSX)
    override internal var flipped:Bool {
        get {
            return true
        }
    }
    #endif
    
    internal init() {
        #if os(iOS) || os(watchOS)
            super.init(effect: UIBlurEffect(style: .Light))
        #elseif os(OSX)
            super.init(frame: NSRect.zero)
            self.material = .Light
            self.blendingMode = .WithinWindow
            
            self.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)
        #endif

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        #if os(OSX)
            self.wantsLayer = true  // NSView will create a CALayer automatically
        #endif
        
        let layer: CALayer! = self.layer

        self.translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 9.0
        layer.masksToBounds = true
        
        #if os(iOS) || os(watchOS)
            contentView.addSubview(self.content)
        #elseif os(OSX)
            self.addSubview(self.content)
        #endif

        
        #if os(iOS) || os(watchOS)
        let offset = 20.0
        
        
        let motionEffectsX = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        motionEffectsX.maximumRelativeValue = offset
        motionEffectsX.minimumRelativeValue = -offset
        
        let motionEffectsY = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        motionEffectsY.maximumRelativeValue = offset
        motionEffectsY.minimumRelativeValue = -offset
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [motionEffectsX, motionEffectsY]
        
        addMotionEffect(group)
        #endif
    }
    
    private var _content = View()
    internal var content: View {
        get {
            return _content
        }
        set {
            _content.removeFromSuperview()
            _content = newValue

            let superView: View
            
            #if os(iOS) || os(watchOS)
                _content.alpha = 0.85
                _content.contentMode = .Center
                _content.clipsToBounds = true
                contentView.addSubview(_content)
                superView = contentView
            #elseif os(OSX)
                _content.alphaValue = 0.85
                addSubview(_content)
                superView = self
            #endif
            
            let centerX = NSLayoutConstraint(item: _content, attribute: .CenterX, relatedBy: .Equal, toItem: superView, attribute: .CenterX, multiplier: 1, constant: 0)
            let centerY = NSLayoutConstraint(item: _content, attribute: .CenterY, relatedBy: .Equal, toItem: superView, attribute: .CenterY, multiplier: 1, constant: 0)
            
            superView.addConstraints([centerX, centerY])
        }
    }
}
