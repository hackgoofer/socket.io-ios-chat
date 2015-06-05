//
//  HipChatRoomViewController.swift
//  HipChat
//
//  Created by Sasha Sheng on 5/9/15.
//  Copyright (c) 2015 Sasha Sheng. All rights reserved.
//

import UIKit

let controlHeight : CGFloat = 37;
let textViewMaxHeight :CGFloat = 150;

let socket = SocketIOClient(socketURL: "http://hipsdontlie.herokuapp.com")
//    let socket = SocketIOClient(socketURL: "http://localhost:8000")

let morseTranslator = MorseCodeTranslator();

class ChatRoomViewController: UIViewController, UITextViewDelegate {
    private var resetAck: AckEmitter? = nil
    private var textView: MessageToolbarTextView? = nil
    private var sendButton: UIButton? = nil

    private var username: String? = nil
    private let placeHolder = "Message";
    
    init(aUserName: String?) {
        super.init(nibName: nil, bundle: nil);
        username = aUserName;
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView = MessageToolbarTextView(frame: CGRectMake(0, self.view.frame.maxY - controlHeight-1, self.view.frame.maxX - controlHeight, controlHeight));
        textView!.delegate = self
        textView!.text = placeHolder
        textView!.textColor = UIColor.grayColor()
        textView!.font = UIFont(name:textView!.font.fontName, size: 18)
        textView!.backgroundColor = UIColor.lightGrayColor()
        textView!.layer.borderWidth = 1;
        textView!.layer.borderColor = UIColor.whiteColor().CGColor
        
        sendButton = UIButton(frame: CGRectMake(textView!.frame.maxX, textView!.frame.minY, 40, controlHeight))
        sendButton!.addTarget(self, action: "sendTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        sendButton!.backgroundColor = UIColor.blueColor()
        
        view.addSubview(sendButton!);
        view.addSubview(textView!);
        view.backgroundColor = UIColor.lightGrayColor()
        addHandlers()
        socket.connect()
    }
    
    override func viewDidDisappear(animated: Bool) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addHandlers() {
        
        socket.on("typing") {data, ack in

        }

        socket.on("new message") {data, ack in
            if let theNewMessage = data?[0]["message"] as? NSString {

            }
            
            if let theUserName = data?[0]["username"] as? NSString {

            }
            
            // TODO: put it on the view
        }
        
        socket.on("connect") {data, ack in
            println("connected");
            
            if self.username != nil {
                socket.emit("add user", self.username!);
            }
        }
        
//        self.socket.onAny {println("Got event: \($0.event), with items: \($0.items)")}
    }
    
    // UIButton tap events
    func sendTapped(button: UIButton) {
        println("Send Button Tapped")
        socket.emit("new message", textView!.text);
    }
    
    // UITextView delegate
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.text == placeHolder {
            textView.text = "";
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        let currentTextViewFrame = textView.frame
        var newSize : CGSize = textView.sizeThatFits(CGSizeMake(currentTextViewFrame.maxX, textViewMaxHeight))

        if currentTextViewFrame.height < newSize.height && currentTextViewFrame.height < textViewMaxHeight {
            var newFrame: CGRect = currentTextViewFrame;
            newSize.width = currentTextViewFrame.width
            newFrame.size = newSize;
            newFrame.origin.y = self.view.frame.maxY - newSize.height - 1
            textView.frame = newFrame;
        }
    }
}


