//
//  ChessPlayerParser.swift
//  MokriyaChessChallenge
//
//  Created by Raja Ayyan on 23/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import Foundation

class ChessPlayerParser: NSObject{
    
    lazy var coreDataApi = CoreDataAPI()
    
    var playerData: NSData?
    var players: [PlayerModal] = []
    var imagenames: [String] = ["carlson","kamnik","kasparov-1","kasparov","viswanathanand","wesley"]
    
    init(data: NSData) {
        self.playerData = data
    }
    
    func parseData(){
        
        var jsonDict: [String: AnyObject]!
        do{
            jsonDict = try NSJSONSerialization.JSONObjectWithData(self.playerData!, options: NSJSONReadingOptions()) as? Dictionary
        }catch {
            print("Error while parsing JSON in ChessPlayerParser class \(error)")
            
        
        }
        
        if let resultDict = jsonDict{
            
            for eachPlayerArray in (resultDict[LEGENDS] as? NSArray)!{
                if let playerDict = eachPlayerArray as? NSDictionary{
                    
                    let rating = (playerDict[PLAYER_RATING] as? Double)!
                    let randomnumber = DataUtils.generateRandomNumber(UInt32(imagenames.count-1))
                    let imagename = imagenames[randomnumber]
                    print("\(imagename)")
                    
                    let player = PlayerModal(name: (playerDict[PLAYER_NAME] as? String)!, withRating: rating, withHistory: [rating], imagename: imagename)
                    
                    
                    self.players.append(player)
                    
                }
                
            }
        }

        coreDataApi.insertChessPlayersData(PLAYERS_TABLE, playersData: self.players)

    }
    
    
    
}
