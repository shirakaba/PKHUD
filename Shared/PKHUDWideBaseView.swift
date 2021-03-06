//
//  PKHUDWideBaseView.swift
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

/// PKHUDWideBaseView provides a wide base view, which you can subclass and add additional views to.
public class PKHUDWideBaseView: View {
    
    static let defaultWideBaseViewFrame = CGRect(origin: CGPointZero, size: CGSize(width: 265.0, height: 90.0))
    
    public init() {
        super.init(frame: PKHUDWideBaseView.defaultWideBaseViewFrame)
        let width = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: PKHUDWideBaseView.defaultWideBaseViewFrame.width)
        let height = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: PKHUDWideBaseView.defaultWideBaseViewFrame.height)
        
        self.addConstraints([width, height])
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    #if os(OSX)
    public override var allowsVibrancy: Bool {
        return true
    }
    #endif
}
