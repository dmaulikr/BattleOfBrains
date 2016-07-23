//
//  HomeScreenCell.swift
//  MokriyaChessChallenge
//
//  Created by Raja Ayyan on 23/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import UIKit

class HomeScreenCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerRating: UILabel!
    @IBOutlet weak var checkboxbutton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.containerView.layer.cornerRadius = 5.0
        //        self.containerview.layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        self.containerView.layer.shadowColor = UIColor.whiteColor().CGColor
        self.containerView.layer.shadowOpacity = 0.8
        self.containerView.layer.shadowRadius = 5.0
        self.containerView.layer.shadowOffset = CGSizeMake(2.0, 2.0)
        
    }

    func configureCell(player: PlayerModal, buttonImagename: String){
        self.playerName.text = player.name
        self.playerRating.text = String(player.currentRating)
        self.checkboxbutton.setImage(UIImage(named: buttonImagename), forState: .Normal)
        self.playerImage.image = UIImage(named: player.playerImage)
    }
}
