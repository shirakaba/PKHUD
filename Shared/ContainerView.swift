//
//  ContainerView.swift
//  Pods
//
//  Created by Fabian Renner on 21.04.16.
//
//

#if os(iOS) || os(watchOS)
    import UIKit
#elseif os(OSX)
    import Cocoa
#endif

internal class ContainerView: View {
    
    #if os(OSX)
    override internal var flipped:Bool {
        get {
            return true
        }
    }
    #endif
    
    #if os(OSX)
    var userInteractionEnabled = false
    #endif
    
    #if os(OSX)
    override func hitTest(aPoint: NSPoint) -> NSView? {
        if userInteractionEnabled {
            return super.hitTest(aPoint)
        }
        return nil
    }
    #endif
    
    internal let frameView: FrameView
    internal init(frameView: FrameView = FrameView()) {
        self.frameView = frameView
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        frameView = FrameView()
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        #if os(OSX)
            self.wantsLayer = true  // NSView will create a CALayer automatically
        #endif
        
        let layer: CALayer! = self.layer
        layer.backgroundColor = Color.clearColor().CGColor
        
        self.translatesAutoresizingMaskIntoConstraints = false

        
        addSubview(backgroundView)
        addSubview(frameView)
        
        let left = NSLayoutConstraint(item: backgroundView, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: backgroundView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: backgroundView, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: backgroundView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
        
        let centerX = NSLayoutConstraint(item: frameView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: frameView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0)
        
        self.addConstraints([left, top, right, bottom])
        self.addConstraints([centerX, centerY])
    }
    
    internal func showFrameView() {
        let layer: CALayer! = self.layer
        layer.removeAllAnimations()
        #if os(iOS) || os(watchOS)
            frameView.alpha = 1.0
        #elseif os(OSX)
            frameView.alphaValue = 1.0
        #endif

        
        let width = NSLayoutConstraint(item: frameView, attribute: .Width, relatedBy: .Equal, toItem: frameView.content, attribute: .Width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: frameView, attribute: .Height, relatedBy: .Equal, toItem: frameView.content, attribute: .Height, multiplier: 1, constant: 0)
        
        frameView.addConstraints([width, height])
        
        hidden = false
    }
    
    private var willHide = false
    
    internal func hideFrameView(animated anim: Bool, completion: ((Bool) -> Void)? = nil) {
        let finalize: (finished: Bool) -> (Void) = { finished in
            if finished {
                self.hidden = true
                self.removeFromSuperview()
            }
            
            self.willHide = false
            completion?(finished)
        }
        
        if hidden {
            return
        }
        
        willHide = true
        
        if anim {
            #if os(iOS) || os(watchOS)
            UIView.animateWithDuration(0.8, animations: {
                self.frameView.alpha = 0.0
                self.hideBackground(animated: false)
                }, completion: finalize)
            #elseif os(OSX)
                NSAnimationContext.runAnimationGroup({ context in
                        context.duration = 0.8
                        self.frameView.animator().alphaValue = 0.0
                        self.hideBackground(animated: false)
                    },
                    completionHandler: { finalize(finished: true) })
            #endif
        } else {
            #if os(iOS) || os(watchOS)
                frameView.alpha = 0.0
            #elseif os(OSX)
                frameView.alphaValue = 0.0
            #endif
            finalize(finished: true)
        }
    }
    
    private let backgroundView: View = {
        let view = View()
        #if os(OSX)
            view.wantsLayer = true
        #endif
    
        let layer: CALayer! = view.layer
        view.translatesAutoresizingMaskIntoConstraints = false
        layer.backgroundColor = Color(white:0.0, alpha:0.25).CGColor
        
        #if os(iOS) || os(watchOS)
            view.alpha = 0.0
        #elseif os(OSX)
            view.alphaValue = 0.0
        #endif
            
        return view
    }()
    
    internal func showBackground(animated anim: Bool) {
        if anim {
            #if os(iOS) || os(watchOS)
                UIView.animateWithDuration(0.175) {
                    self.backgroundView.alpha = 1.0
                }
            #elseif os(OSX)
                NSAnimationContext.runAnimationGroup({ context in
                        context.duration = 0.175
                        self.backgroundView.animator().alphaValue = 1.0
                    },
                    completionHandler: nil)
            #endif
        } else {
            #if os(iOS) || os(watchOS)
                backgroundView.alpha = 1.0
            #elseif os(OSX)
                backgroundView.alphaValue = 0.0
            #endif
        }
    }
    
    internal func hideBackground(animated anim: Bool) {
        if anim {
            #if os(iOS) || os(watchOS)
                UIView.animateWithDuration(0.65) {
                    self.backgroundView.alpha = 0.0
                }
            #elseif os(OSX)
                NSAnimationContext.runAnimationGroup({ context in
                        context.duration = 0.65
                        self.backgroundView.animator().alphaValue = 0.0
                    },
                    completionHandler: nil)
            #endif
        } else {
            #if os(iOS) || os(watchOS)
                backgroundView.alpha = 0.0
            #elseif os(OSX)
                backgroundView.alphaValue = 0.0
            #endif
        }
    }
}
