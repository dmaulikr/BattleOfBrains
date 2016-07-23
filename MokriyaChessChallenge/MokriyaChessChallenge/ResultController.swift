//
//  ResultController.swift
//  BattleOfBrains
//
//  Created by administrator on 23/07/16.
//  Copyright © 2016 phani_practice. All rights reserved.
//

import UIKit

class ResultController: UIViewController {
    
    @IBOutlet weak var winnerImage: UIImageView!
    @IBOutlet weak var winnerName: UILabel!
    @IBOutlet weak var winnerRating: UILabel!
    @IBOutlet weak var winnerUpdate: UILabel!
    
    @IBOutlet weak var loserName: UILabel!
    @IBOutlet weak var loserRating: UILabel!
    @IBOutlet weak var loserUpdate: UILabel!
    @IBOutlet weak var loserImage: UIImageView!
    
    
    var players:[PlayerModal]!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        winnerName.text = players[0].name;
        winnerRating.text = "Rating: \(Int(players[0].currentRating))";
        
        var update = players[0].previousRatings[1] - players[0].previousRatings[0];
        winnerUpdate.text = "\(Int(update))";
        
        winnerImage.image = UIImage(named: players[0].playerImage);
        
        loserName.text = players[1].name;
        loserRating.text = "Rating: \(Int(players[1].currentRating))";
        
        update = players[1].previousRatings[1] - players[0].previousRatings[0];
        loserUpdate.text = "\(Int(update))";
        
        loserImage.image = UIImage(named: players[1].playerImage);
        
        self.navigationController?.navigationItem.hidesBackButton = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(ResultController.dismiss))
        self.navigationItem.setHidesBackButton(true, animated:true);
        
    }
    
    @IBAction func showStatistcs(sender: AnyObject) {
        
        let vc = DashboardController.init(nibName: nil, bundle: nil, players)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    
}
