//
//  ErrorVC.swift
//  MokriyaChessChallenge
//
//  Created by Raja Ayyan on 23/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import UIKit

protocol ErrorDelegate {
    func doneButtonClicked()
}

class ErrorVC: UITableViewController {
    
    

    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    let appdelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    var delegate: ErrorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  appdelegate!.selectedPlayers.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("errorcell", forIndexPath: indexPath) as? PlayerErrorCell

        if appdelegate!.selectedPlayers.count > 0 {
            cell?.configureCell(appdelegate!.selectedPlayers[indexPath.row])
            
        }

        return cell!
    }
    
    @IBAction func buttonSelected(sender: AnyObject) {
        let button = sender as? UIButton
        if let cell = button?.superview?.superview as? PlayerErrorCell{
            
            let indexpath = self.tableView.indexPathForCell(cell)
            let player = appdelegate!.selectedPlayers[(indexpath?.row)!]
            
            //find the player in appdelegate selected player
            let i = appdelegate!.selectedPlayers.indexOf({$0.name == player.name})
            if i != nil{
                //uncheck
                appdelegate!.selectedPlayers.removeAtIndex(i!)
                button?.setImage(UIImage(named: "checked"), forState: .Normal)
            }else{
                //check
                appdelegate!.selectedPlayers.append(player)
                button?.setImage(UIImage(named: "unchecked"), forState: .Normal)
                
                
            }
            
            delegate?.doneButtonClicked()
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            
        }

        
    }
    
    
   
    
    
}
