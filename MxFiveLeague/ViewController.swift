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
    @IBOutlet var finishButton : UIButton
    @IBOutlet var clearButton : UIButton
    @IBOutlet var charNumerLabel : UILabel

    var charNumber      = 1
    var maxCharNumber   = 4
    
    var bezierPath    = UIBezierPath?()
    var undoStack     = UIBezierPath[]()
    var redoStack     = UIBezierPath[]()
    var lastDrawImage = UIImage?()
    
    // TODO: reusable objects
    var pagePathHistory: UIBezierPath[][] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.updateCharNumber()
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
        self.bezierPath!.lineWidth = 12
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
        UIColor.whiteColor().setStroke()
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
//        UIImageWriteToSavedPhotosAlbum(self.canvas.image, self, nil, nil)
        
        self.pagePathHistory.append(self.undoStack)
        self.showAndHideCopyCanvas(self.canvas)
        self.didPressClearButton(self.clearButton)
        self.charNumber++
        self.updateCharNumber()
    }
    
    @IBAction func didPressFinishButton(sender : UIButton) {
        NSLog("Finish")
    }
    
    func showAndHideCopyCanvas(canvas: UIImageView) {
        var cloneCanvas = UIImageView(image: canvas.image)
        self.canvas.addSubview(cloneCanvas)
        UIView.animateWithDuration(0.3, animations: {() -> Void in
                cloneCanvas.frame.origin.x = -cloneCanvas.frame.width
            }, completion: {(Bool) -> Void in
                cloneCanvas.removeFromSuperview()
                cloneCanvas.image = nil
            })
    }
    
    func updateCharNumber() {
        self.charNumerLabel.text = "\(self.charNumber)文字目"
        if self.charNumber >= self.maxCharNumber {
            self.nextButton.hidden = true
            self.finishButton.hidden = false
        }
    }
    
}

