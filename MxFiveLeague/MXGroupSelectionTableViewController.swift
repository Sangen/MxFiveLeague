//
//  GroupSelectionTableViewController.swift
//  MxFiveLeague
//
//  Created by KaoruKawakita on 6/15/14.
//  Copyright (c) 2014 KaoruKawakita. All rights reserved.
//

import UIKit

class MXGroupSelectionTableViewController: UITableViewController {

    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.selectGroupRowAtIndex(MXUserDefaults.groupID())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.selectGroupRowAtIndex(indexPath.row)
        MXUserDefaults.setGroupID(indexPath.row)
    }
    
    func selectGroupRowAtIndex(index: Int) {
        let cells = self.tableView.visibleCells()
        for object: AnyObject in cells {
            let cell = object as? UITableViewCell
            if self.tableView.indexPathForCell(cell).row == index {
                cell!.accessoryType = .Checkmark
            } else {
                cell!.accessoryType = .None
            }
        }
    }

}
