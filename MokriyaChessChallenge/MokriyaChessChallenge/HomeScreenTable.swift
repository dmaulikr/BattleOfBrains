//
//  HomeScreenTable.swift
//  MokriyaChessChallenge
//
//  Created by Raja Ayyan on 23/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import UIKit

class HomeScreenTable: UITableViewController, ErrorDelegate {
    
    var pageIndex:Int!
    var players: [PlayerModal] = []
    let appdelegate = UIApplication.sharedApplication().delegate as? AppDelegate



    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor.clearColor()

    }

 

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if players.count > 0{
            return players.count
        }else{
            return 0
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? HomeScreenCell
        
        if players.count > 0 {
            
            let player = self.players[indexPath.row]

            let i = appdelegate!.selectedPlayers.indexOf({$0.name == player.name})
            if i != nil{
                cell?.configureCell(player, buttonImagename: "checked")

            }else{
                cell?.configureCell(player, buttonImagename: "unchecked")

            }
        }
        return cell!
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.alpha = 0
        UIView.animateWithDuration(2.0) {
            cell.alpha = 1
        }
    }
    
   
    
    
    @IBAction func selectedButtonAction(sender: AnyObject) {
        
        let button = sender as? UIButton
        if let cell = button?.superview?.superview?.superview as? HomeScreenCell{
            
            let indexpath = self.tableView.indexPathForCell(cell)
            let player = self.players[(indexpath?.row)!]
            
            //find the player in appdelegate selected player
            let i = appdelegate!.selectedPlayers.indexOf({$0.name == player.name})
            if i != nil{
                //uncheck
                appdelegate!.selectedPlayers.removeAtIndex(i!)
                button?.setImage(UIImage(named: "unchecked"), forState: .Normal)
            }else{
                //check
                appdelegate!.selectedPlayers.append(player)
                button?.setImage(UIImage(named: "checked"), forState: .Normal)


            }
            
            if appdelegate!.selectedPlayers.count > 2 {
                self.performSegueWithIdentifier(StoryBoard_Segue_Constatns.ERRPR_VC_SEGUE, sender: self)
            }
            
            
           //print(appdelegate?.selectedPlayers)
            
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //let navcontroller = segue.destinationViewController as? UINavigationController
        if segue.identifier == StoryBoard_Segue_Constatns.ERRPR_VC_SEGUE{
            
            let navcontroller = segue.destinationViewController as? UINavigationController
            if let controller = navcontroller?.topViewController as? ErrorVC{
            //if let controller = segue.destinationViewController as? ErrorVC{
                controller.delegate = self
            }

            
        }
    }
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == StoryBoard_Segue_Constatns.ERRPR_VC_SEGUE{
            if appdelegate!.selectedPlayers.count < 2 {
                return false
            }
        }
        return true
    }
    

    func doneButtonClicked(){
        self.tableView.reloadData()
    }

    
}
