//
//  HostSelectionTableViewController.swift
//  MxFiveLeague
//
//  Created by Kaoru Kawakita on 2014/06/14.
//  Copyright (c) 2014 KaoruKawakita. All rights reserved.
//

import UIKit

class MXURLSelectionTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var nowUrlTextField: UITextField
    @IBOutlet var tableView: UITableView
    var baseURLHistory = String[]()
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseURLHistory = MXUserDefaults.baseURLHistory()
        self.nowUrlTextField.text = MXUserDefaults.baseURL()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateURL(url: String) {
        MXUserDefaults.addBaseURLToHistroy(url)
        self.baseURLHistory = MXUserDefaults.baseURLHistory()
        self.tableView.reloadData()
        self.nowUrlTextField.text = url
    }

    @IBAction func didPressUseButton(sender: AnyObject) {
        self.updateURL(self.nowUrlTextField.text)
    }
    
    // #pragma mark - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }

    func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return self.baseURLHistory.count
    }
    
    func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath:NSIndexPath!) -> UITableViewCell! {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        cell.text = self.baseURLHistory[indexPath.row]
        return cell;
    }
    
    func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath:NSIndexPath!) {
        let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        self.updateURL(cell.text)
    }

}
