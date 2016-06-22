//
//  PKHUDTextView.swift
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

/// PKHUDTextView provides a wide, three line text view, which you can use to display information.
public class PKHUDTextView: PKHUDWideBaseView {
    
    public init(text: String?) {
        super.init()
        commonInit(text)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit("")
    }
    
    func commonInit(text: String?) {
        #if os(iOS) || os(watchOS)
            titleLabel.text = text
        #elseif os(OSX)
            titleLabel.stringValue = text ?? ""
        #endif
        
        addSubview(titleLabel)

        setCorrectFrames()
    }
    
    #if os(iOS) || os(watchOS)
        public let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .Center
            label.font = UIFont.boldSystemFontOfSize(17.0)
            label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.85)
            label.adjustsFontSizeToFitWidth = true
            label.numberOfLines = 3
            return label
        }()
    #elseif os(OSX)
        public let titleLabel: NSTextField = {
            let textField = NSTextField()
            textField.alignment = .Center
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.font = NSFont.systemFontOfSize(17.0)
            textField.textColor = Color.blackColor().colorWithAlphaComponent(0.85)
            textField.maximumNumberOfLines = 3
            textField.bezeled = false
            textField.drawsBackground = false
            textField.editable = false
            textField.selectable = false
            return textField
        }()
    #endif
    
    func setCorrectFrames() {
        translatesAutoresizingMaskIntoConstraints = false
        let left = NSLayoutConstraint(item: titleLabel, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 10)
        let right = NSLayoutConstraint(item: titleLabel, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: -10)
        
        let centerY = NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0)
        
        self.addConstraints([left, right])
        self.addConstraints([centerY])
    }
}
