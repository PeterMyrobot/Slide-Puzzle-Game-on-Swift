//
//  LeaderboardViewController.swift
//  SlidePuzzleII
//
//  Created by apple on 18/07/2016.
//  Copyright © 2016 Peter. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    

    
    var leaderboardNameArray = ["Peter", "Limi", "-", "-", "-", "-", "-", "-", "-", "-"]
    var leaderboardStepArray = [123, 155, 999, 999, 999, 999, 999, 999, 999, 999]
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! leaderboardTableViewCell
        if indexPath.row > 2{
            cell.crownLb.text = "    "
        }
        cell.gradeLabel.text = "\(indexPath.row + 1)"
        cell.nameLabel.text = leaderboardNameArray[indexPath.row]
        cell.stepLabel.text = "\(leaderboardStepArray[indexPath.row])"

        return cell
        
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
