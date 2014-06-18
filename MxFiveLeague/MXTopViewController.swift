//
//  MXTopViewController.swift
//  MxFiveLeague
//
//  Created by KaoruKawakita on 6/17/14.
//  Copyright (c) 2014 KaoruKawakita. All rights reserved.
//

import UIKit

class MXTopViewController: UIViewController {

    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressCharButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("MXGameViewController") as MXGameViewController
        vc.maxCharNumber = sender.tag
        self.presentViewController(vc, animated: true, completion: nil)
    }

    // #pragma mark - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue?.identifier == "prepareForSegue" {
            var vc = segue!.destinationViewController as MXGameViewController
            vc.maxCharNumber = (sender as UIButton).tag
        }
    }

}
