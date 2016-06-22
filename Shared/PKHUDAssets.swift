//
//  PKHUD.Assets.swift
//  PKHUD
//
//  Created by Philip Kluz on 6/18/14.
//  Copyright (c) 2016 NSExceptional. All rights reserved.
//  Licensed under the MIT license.
//

#if os(iOS) || os(watchOS)
    import UIKit
#elseif os(OSX)
    import Cocoa
#endif

/// PKHUDAssets provides a set of default images, that can be supplied to the PKHUD's content views.
public class PKHUDAssets: NSObject {
    
    public class var crossImage: Img { return PKHUDAssets.bundledImage(named: "cross") }
    public class var checkmarkImage: Img { return PKHUDAssets.bundledImage(named: "checkmark") }
    public class var progressActivityImage: Img { return PKHUDAssets.bundledImage(named: "progress_activity") }
    public class var progressCircularImage: Img { return PKHUDAssets.bundledImage(named: "progress_circular") }
    
    internal class func bundledImage(named name: String) -> Img {
        let bundle = NSBundle(forClass: PKHUDAssets.self)
        #if os(iOS) || os(watchOS)
            let image = Img(named: name, inBundle: bundle, compatibleWithTraitCollection: nil)
        #elseif os(OSX)
            let image = bundle.imageForResource(name)
        #endif
        if let image = image {
            return image
        }
        
        return Img()
    }
}
