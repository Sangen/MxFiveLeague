//
//  MXCanvasModel.swift
//  MxFiveLeague
//
//  Created by KaoruKawakita on 6/16/14.
//  Copyright (c) 2014 KaoruKawakita. All rights reserved.
//

import UIKit

class MXCanvasModel: NSObject {
   
    class func upload(#image: UIImage, groupName: String, charNumber: Int) {
        let url = NSURL(string: "http://api.tiqav.com/search/random.json")
        var req = NSMutableURLRequest(URL: url)
        req.HTTPMethod = "POST"
        req.HTTPBody   = "HogeFuga".dataUsingEncoding(NSUTF8StringEncoding)

//        let connection: NSURLConnection = NSURLConnection(request: req, delegate: self, startImmediately: false)
//        
//        // NSURLConnectionを使ってアクセス
//        NSURLConnection.sendAsynchronousRequest(Req,
//            queue: NSOperationQueue.mainQueue(),
//            completionHandler: self.fetchResponse)
    }
}
