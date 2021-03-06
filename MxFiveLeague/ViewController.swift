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
    @IBOutlet var undoButton : UIButton
    @IBOutlet var redoButton : UIButton
    @IBOutlet var clearButton : UIButton

    var bezierPath    = UIBezierPath?()
    var undoStack     = UIBezierPath[]()
    var redoStack     = UIBezierPath[]()
    var lastDrawImage = UIImage?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.undoButton.enabled = false
        self.redoButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        let currentPoint = touches.anyObject().locationInView(self.canvas)
        // through if touched point is on any buttons
        if CGRectContainsPoint(self.undoButton.frame, currentPoint) ||
           CGRectContainsPoint(self.redoButton.frame, currentPoint) ||
           CGRectContainsPoint(self.clearButton.frame, currentPoint) ||
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
        
        self.undoButton.enabled = true
        self.redoButton.enabled = false
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

    @IBAction func didPressUndoButton(sender : UIButton) {
        // undo -> redo
        let undoPath: UIBezierPath = self.undoStack[self.undoStack.endIndex - 1]
        self.undoStack.removeLast()
        self.redoStack.append(undoPath)
        
        // clear canvas
        self.lastDrawImage = nil
        self.canvas.image = nil
        
        for path in self.undoStack {
            self.drawLine(path: path)
            self.lastDrawImage = self.canvas.image
        }
        
        self.undoButton.enabled = !self.undoStack.isEmpty
        self.redoButton.enabled = true
    }
    
    @IBAction func didPressRedoButton(sender : UIButton) {
        // undo -> redo
        let redoPath: UIBezierPath = self.redoStack[self.redoStack.endIndex - 1]
        self.redoStack.removeLast()
        self.undoStack.append(redoPath)
        
        self.drawLine(path: redoPath)
        self.lastDrawImage = self.canvas.image
        
        self.undoButton.enabled = true
        self.redoButton.enabled = !self.redoStack.isEmpty
    }
    
    @IBAction func didPressClearButton(sender : UIButton) {
        self.undoStack.removeAll(keepCapacity: false)
        self.redoStack.removeAll(keepCapacity: false)
        
        self.lastDrawImage = nil
        self.canvas.image = nil
        
        self.undoButton.enabled = false
        self.redoButton.enabled = false
    }
    
    @IBAction func didPressNextButton(sender : UIButton) {
    }
    
}

