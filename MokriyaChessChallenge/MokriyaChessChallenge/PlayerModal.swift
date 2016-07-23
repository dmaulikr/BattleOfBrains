//
//  PlayerModal.swift
//  BattleOfBrains
//
//  Created by administrator on 23/07/16.
//  Copyright © 2016 phani_practice. All rights reserved.
//

// this class contains the player modals which has information about players name, ratings, profile image and his previous ratings.

import Foundation

class PlayerModal:NSObject
{
    let name:String;
    var currentRating:Double
    var previousRatings:[Double]
    var playerImage: String
    
    init(name:String, withRating rating:Double, withHistory previousRatings:[Double], imagename: String) {
        self.name = name;
        self.currentRating = rating;
        self.previousRatings = previousRatings;
        self.playerImage = imagename
        super.init();
    }
    
    func updateRating(rating:Double)
    {
        self.currentRating = rating;
        self.previousRatings.insert(rating, atIndex: 0);
        
        if(self.previousRatings.count>5)
        {
            self.previousRatings.removeLast();
        }
    }
    
}