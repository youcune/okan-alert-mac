//
//  ViewController.swift
//  OkanAlert
//
//  Created by Yu Nakanishi on 2015/06/02.
//  Copyright (c) 2015年 Yu Nakanishi. All rights reserved.
//

import Cocoa
import Starscream

class ViewController: NSViewController, WebSocketDelegate {

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

    func websocketDidConnect(socket: WebSocket) {
        println("websocket is connected")
        socket.writeString("Hi Server!")
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        println("websocket is disconnected: \(error?.localizedDescription)")
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        println("got some text: \(text)")
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: NSData) {
        println("got some data: \(data.length)")
    }
}
