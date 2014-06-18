//
//  InfoTableViewController.swift
//  MxFiveLeague
//
//  Created by Kaoru Kawakita on 2014/06/14.
//  Copyright (c) 2014 KaoruKawakita. All rights reserved.
//

import UIKit

class InfoTableViewController: UITableViewController {
    
    @IBOutlet var groupNameLabel : UILabel
    @IBOutlet var baseURLLabel : UILabel
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    init(style: UITableViewStyle) {
        super.init(style: style)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.groupNameLabel.text = MXUserDefaults.groupName()
        self.baseURLLabel.text   = MXUserDefaults.baseURL()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPushDoneButton(sender : UIBarButtonItem) {
        self.dismissModalViewControllerAnimated(true)
    }
    
    // #pragma mark - Table view data source
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }

}
