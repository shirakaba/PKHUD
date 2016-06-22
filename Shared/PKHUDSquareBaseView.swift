//
//  PKHUDSquareBaseView.swift
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

/// PKHUDSquareBaseView provides a square view, which you can subclass and add additional views to.
public class PKHUDSquareBaseView: View {
    
    static let defaultSquareBaseViewFrame = CGRect(origin: CGPointZero, size: CGSize(width: 156.0, height: 156.0))

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    #if os(OSX)
    override public var flipped:Bool {
        get {
            return true
        }
    }
    #endif
    
    public func commonInit() {
        self.setCorrectFrames()
        
        #if os(OSX)
            self.wantsLayer = true  // NSView will create a CALayer automatically
        #endif
    }

    public init(image: Img? = nil, title: String? = nil, subtitle: String? = nil) {
        super.init(frame: PKHUDSquareBaseView.defaultSquareBaseViewFrame)
        
        commonInit()
        
        self.imageView.image = image
        #if os(iOS) || os(watchOS)
            titleLabel.text = title
            subtitleLabel.text = subtitle
        #elseif os(OSX)
            titleLabel.stringValue = title ?? ""
            subtitleLabel.stringValue = subtitle ?? ""
        #endif
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }

    public let imageView: ImageView = {
        let imageView = ImageView()

        #if os(iOS) || os(watchOS)
            imageView.alpha = 0.85
        #elseif os(OSX)
            imageView.alphaValue = 0.85
            imageView.wantsLayer = true
        #endif

        let layer: CALayer! = imageView.layer

        layer.contentsGravity = kCAGravityCenter
        return imageView
    }()
    
    #if os(iOS) || os(watchOS)
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.boldSystemFontOfSize(17.0)
        label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.85)
        return label
    }()
    #elseif os(OSX)
    public let titleLabel: NSTextField = {
        let textField = NSTextField()
        textField.alignment = .Center
        textField.font = NSFont.systemFontOfSize(17.0)
        textField.textColor = Color.blackColor().colorWithAlphaComponent(0.85)
        textField.bezeled = false
        textField.drawsBackground = false
        textField.editable = false
        textField.selectable = false
        return textField
    }()
    #endif
    
    #if os(iOS) || os(watchOS)
    public let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.boldSystemFontOfSize(14.0)
        label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    #elseif os(OSX)
    public let subtitleLabel: NSTextField = {
        let textField = NSTextField()
        textField.alignment = .Center
        textField.font = NSFont.systemFontOfSize(14.0)
        textField.textColor = Color.blackColor().colorWithAlphaComponent(0.7)
        textField.maximumNumberOfLines = 2
        textField.bezeled = false
        textField.drawsBackground = false
        textField.editable = false
        textField.selectable = false
        return textField
    }()
    #endif
    
    #if os(OSX)
    public override var allowsVibrancy: Bool {
        return true
    }
    #endif
    
    func setCorrectFrames() {
        self.translatesAutoresizingMaskIntoConstraints = true
        
        let viewWidth = bounds.size.width
        let viewHeight = bounds.size.height
        
        let halfHeight = CGFloat(ceilf(CFloat(viewHeight / 2.0)))
        let quarterHeight = CGFloat(ceilf(CFloat(viewHeight / 4.0)))
        let threeQuarterHeight = CGFloat(ceilf(CFloat(viewHeight / 4.0 * 3.0)))
        
        titleLabel.frame = CGRect(origin: CGPointZero, size: CGSize(width: viewWidth, height: quarterHeight))
        imageView.frame = CGRect(origin: CGPoint(x:0.0, y:quarterHeight), size: CGSize(width: viewWidth, height: halfHeight))
        subtitleLabel.frame = CGRect(origin: CGPoint(x:0.0, y:threeQuarterHeight), size: CGSize(width: viewWidth, height: quarterHeight))
    }
}
