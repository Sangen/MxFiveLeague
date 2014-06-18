//
//  MXCanvasModel.swift
//  MxFiveLeague
//
//  Created by KaoruKawakita on 6/16/14.
//  Copyright (c) 2014 KaoruKawakita. All rights reserved.
//

import UIKit

class MXCanvasModel: NSObject {
    
    class func upload(#image: UIImage,
                   groupName: String,
                  charNumber: Int,
           completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)!) {
        
        // TODO:
        // png to base64
        // set img param to session

        let url  = NSURL.URLWithString("\(MXUserDefaults.baseURL())/upload")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task    = session.dataTaskWithURL(url, completionHandler: {
            (data, resp, err) in
            completionHandler(data, resp, err)
            println(NSString(data: data, encoding:NSUTF8StringEncoding))
        })
        task.resume()
    }
    
    
    class func toBase64(#image: UIImage) -> String {
        let pngData = UIImagePNGRepresentation(image)
        return pngData.base64Encoding()
    }
}
