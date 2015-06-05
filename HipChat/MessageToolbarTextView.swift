//
//  MessageToolbarTextView.swift
//  HipChat
//
//  Created by Sasha Sheng on 6/5/15.
//  Copyright (c) 2015 Sasha Sheng. All rights reserved.
//

import UIKit
import Foundation

class MessageToolbarTextView: UITextView {
    
    /**
    *  The text to be displayed when the text view is empty. The default value is `nil`.
    */
    private var _placeHolder : NSString?
    var placeHolder : NSString? {
        set {
            _placeHolder = newValue
            self.setNeedsDisplay()
        }
        get {
            return _placeHolder
        }
    }
    /**
    *  The color of the place holder text. The default value is `[UIColor lightGrayColor]`.
    */
    private var _placeHolderTextColor : UIColor?
    var placeHolderTextColor : UIColor? {
        set {
            _placeHolderTextColor = newValue
            self.setNeedsDisplay()
        }
        
        get {
            return _placeHolderTextColor
        }
    }
    
    /**
    *  Determines whether or not the text view contains text after trimming white space
    *  from the front and back of its string.
    *
    *  @return `YES` if the text view contains text, `NO` otherwise.
    */
    override func hasText() -> Bool {
        let text : NSString = self.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return text.length > 0;
    }
    
}
