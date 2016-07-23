//
//  PlayerErrorCell.swift
//  MokriyaChessChallenge
//
//  Created by Raja Ayyan on 23/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import UIKit

class PlayerErrorCell: UITableViewCell {
    
    
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(player:PlayerModal){
        self.playerName.text = player.name
        
        if player.playerImage != ""{
            self.playerImage.image = UIImage(named: player.playerImage)
        }else{
            self.playerImage.image = UIImage(named: "kasparov")
        }
    }
}
