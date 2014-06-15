//
//  ViewController.swift
//  MxFiveLeague
//
//  Created by KaoruKawakita on 6/9/14.
//  Copyright (c) 2014 KaoruKawakita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var canvas : UIImageView
    @IBOutlet var nextButton : UIButton
    @IBOutlet var clearButton : UIButton

    var bezierPath    = UIBezierPath?()
    var undoStack     = UIBezierPath[]()
    var redoStack     = UIBezierPath[]()
    var lastDrawImage = UIImage?()
    
    // TODO: reusable objects
    var pagePathHistory: UIBezierPath[][] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        let currentPoint = touches.anyObject().locationInView(self.canvas)
        // through if touched point is on any buttons
        if CGRectContainsPoint(self.clearButton.frame, currentPoint) ||
           CGRectContainsPoint(self.nextButton.frame, currentPoint) {
            return
        }
        // initialize path
        self.bezierPath = UIBezierPath()
        self.bezierPath!.lineCapStyle = kCGLineCapRound
        self.bezierPath!.lineWidth = 4
        self.bezierPath!.moveToPoint(currentPoint)
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        if !self.bezierPath { return }
        let currentPoint = touches.anyObject().locationInView(self.canvas)
        self.bezierPath!.addLineToPoint(currentPoint)
        self.drawLine(path: self.bezierPath!)
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        if !self.bezierPath { return }
        let currentPoint = touches.anyObject().locationInView(self.canvas)
        self.bezierPath!.addLineToPoint(currentPoint)
        self.drawLine(path: self.bezierPath!)
        // save laste image and undo stack
        self.lastDrawImage = self.canvas.image
        self.undoStack.append(self.bezierPath!)
        self.redoStack.removeAll(keepCapacity: false)
        self.bezierPath = nil
    }
    
    func drawLine(#path: UIBezierPath) {
        // generate hidden drawspace
        UIGraphicsBeginImageContext(self.canvas.frame.size)
        self.lastDrawImage?.drawAtPoint(CGPointZero)
        UIColor.lightGrayColor().setStroke()
        path.stroke()
        self.canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func didPressClearButton(sender : UIButton) {
        self.undoStack.removeAll(keepCapacity: false)
        self.redoStack.removeAll(keepCapacity: false)
        
        self.lastDrawImage = nil
        self.canvas.image = nil
    }
    
    @IBAction func didPressNextButton(sender : UIButton) {
        UIImageWriteToSavedPhotosAlbum(self.canvas.image, self, nil, nil)
        
        self.pagePathHistory.append(self.undoStack)
        self.didPressClearButton(self.clearButton)
    }
    
//     画像を保存する
//    func save {
//    //保存する画像を指定
//    UIImage *image = [UIImage imageNamed:_imageName];
//    //画像保存完了時のセレクタ指定
//    SEL selector = @selector(onCompleteCapture:didFinishSavingWithError:contextInfo:);
//    //画像を保存する
//    UIImageWriteToSavedPhotosAlbum(image, self, selector, NULL);
//    }
//    
//    //画像保存完了時のセレクタ
//    - (void)onCompleteCapture:(UIImage *)screenImage
//    didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//    {
//    NSString *message = @"画像を保存しました";
//    if (error) message = @"画像の保存に失敗しました";
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @""
//    message: message
//    delegate: nil
//    cancelButtonTitle: @"OK"
//    otherButtonTitles: nil];
//    [alert show];
//    }
}

