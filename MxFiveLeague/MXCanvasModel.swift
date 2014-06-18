//
//  MXCanvasModel.swift
//  MxFiveLeague
//
//  Created by KaoruKawakita on 6/16/14.
//  Copyright (c) 2014 KaoruKawakita. All rights reserved.
//

import UIKit

class MXCanvasModel: NSObject {
    
    class func upload(#image: UIImage?,
                   groupName: String,
                  charNumber: Int,
           completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)!)
    {
        let url = "http://0.0.0.0:8000/"
        let params = ["group"   : groupName,
                      "charNum" : "\(charNumber)",
                      "image"   : MXCanvasModel.toBase64(image: image)]
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()  /////////////////////

        manager.GET(url,
//        manager.POST(url,
            parameters: params,
            success: { (task: NSURLSessionDataTask!, responseObject:AnyObject!) in
                println("response: \(responseObject)")
            },
            failure: { (task: NSURLSessionDataTask!, error: NSError!) in
                println("Error: \(error)")
            })
    }
    
    
    class func toBase64(#image: UIImage?) -> String {
        if !image {
            return ""
        }
        let pngData = UIImagePNGRepresentation(image)
        return pngData.base64Encoding()
//        return pngData.base64EncodedDataWithOptions(options: NSDataBase64EncodingOptions)
    }
}
