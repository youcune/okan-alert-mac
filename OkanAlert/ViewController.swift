//
//  ViewController.swift
//  OkanAlert
//
//  Created by Yu Nakanishi on 2015/06/02.
//  Copyright (c) 2015年 Yu Nakanishi. All rights reserved.
//

import Cocoa
import Starscream

class ViewController: NSViewController, WebSocketDelegate, NSUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var socket = WebSocket(url: NSURL(scheme: "ws", host: "localhost:8080", path: "/")!)
        socket.delegate = self
        socket.connect()

        // Do any additional setup after loading the view.
        
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    // ---------------------------------------------------------------
    // WebSocketDelegate
    // ---------------------------------------------------------------
    func websocketDidConnect(socket: WebSocket) {
        println("websocket is connected")
        socket.writeString("Hi Server!")
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        println("websocket is disconnected: \(error?.localizedDescription)")
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        if (text == "ALERT") {
            notify("【警報】避難体勢を取ってください！", image: "alert.png")
        }
        else if (text == "OK") {
            notify("周囲は安全な状態です。", image: "ok.png")
        }
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: NSData) {
        println("got some data: \(data.length)")
    }
    
    // ---------------------------------------------------------------
    // NSUserNotificationCenterDelegate
    // ---------------------------------------------------------------
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func notify(text: String, image: String) {
        NSUserNotificationCenter.defaultUserNotificationCenter().delegate = self
        let notification = NSUserNotification()
        notification.title = "OkanAlert"
        notification.informativeText = text
        notification.contentImage = NSImage(named: image)
        NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(notification)
    }
}
