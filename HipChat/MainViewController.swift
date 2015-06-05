//
//  ViewController.swift
//  HipChat
//
//  Created by Sasha Sheng on 5/9/15.
//  Copyright (c) 2015 Sasha Sheng. All rights reserved.
//

import UIKit

let xMargin = CGFloat(20.0);
let standardHeight = CGFloat(40.0);
let cornerRadius = CGFloat(2.0);

class ViewController: UIViewController {
    var myTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let widthOfControl = self.view.bounds.size.width-2*xMargin;
        let yLocationForTextField : CGFloat = 240.0;
        
        //TODO: center the locations
        self.view.backgroundColor = UIColor.darkGrayColor();
        
        myTextField = UITextField(frame: CGRect(x:xMargin, y:yLocationForTextField, width:widthOfControl, height:standardHeight));
        myTextField!.placeholder = "What's your nickname?";
        myTextField!.layer.cornerRadius = cornerRadius;
        myTextField!.textColor = UIColor.whiteColor();
        
        let underline: UIView = UIView(frame: CGRect(x:xMargin, y:yLocationForTextField+standardHeight, width:widthOfControl, height: 2.00));
        underline.backgroundColor = UIColor.whiteColor();
        underline.layer.cornerRadius = cornerRadius;
        
        let loginButton: UIButton = UIButton(frame: CGRect(x:xMargin, y:underline.frame.maxY+15, width:widthOfControl, height: standardHeight));
        loginButton.backgroundColor = UIColor.grayColor();
        loginButton.layer.cornerRadius = 4.0;
        loginButton.setTitle("Login", forState:(UIControlState.Normal));
        loginButton.addTarget(self, action: "loginTapped:", forControlEvents: UIControlEvents.TouchUpInside);
        
        self.view.addSubview(myTextField!);
        self.view.addSubview(underline);
        self.view.addSubview(loginButton);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginTapped(button: UIButton) {
        var username: String? = myTextField!.text;
        var hipViewController: ChatRoomViewController = ChatRoomViewController(aUserName: username);
        self.presentViewController(hipViewController, animated: true) { () -> Void in
            
        }
    }
}
