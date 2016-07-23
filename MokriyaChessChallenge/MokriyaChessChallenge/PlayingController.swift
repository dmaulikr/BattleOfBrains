//
//  ViewController.swift
//  BattleOfBrains
//
//  Created by administrator on 23/07/16.
//  Copyright © 2016 phani_practice. All rights reserved.
//

import UIKit

class PlayingController: UIViewController {

    @IBOutlet weak var webview: UIWebView!
    
    var player1: PlayerModal?
    var player2: PlayerModal?
    
    @IBOutlet weak var playinggitimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        performSelector(#selector(showStatistics), withObject: nil, afterDelay: 2)

        self.navigationItem.title = "Playing"
        
    
        
        let jeremyGif = UIImage.gifWithName("chess")
        self.playinggitimage.image = jeremyGif

    
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showStatistics()
    {
        playMatchAndUpdateRatings(player1!,player2!);
       
    }
    
    enum MatchResult{
        case playerAWins
        case playerBWins
        case matchDrawn
    }
    
    func playMatchAndUpdateRatings(playerA:PlayerModal,_ playerB:PlayerModal)
    {
        let n = 40.0;
        let kfactor = 32.0;
        
        let player1TR = (10 * (playerA.currentRating))/n;
        let player2TR = (10 * (playerB.currentRating))/n;
        
        let player1ER = (player1TR)/(player1TR+player2TR);
        let player2ER = (player2TR)/(player1TR+player2TR);
        
        var player1SR = 0.0;
        var player2SR = 0.0;
        
        switch(getResultOfMatch())
        {
            case .playerAWins:
                player1SR = 1.0;
            
            case .playerBWins:
                player2SR = 2.0;
            
            case .matchDrawn:
                player1SR = 0.5;
                player2SR = 0.5;
        }
        
        let player1UR = playerA.currentRating + kfactor * (player1SR - player1ER)
        let player2UR = playerB.currentRating + kfactor * (player2SR - player2ER)
        
        playerA.updateRating(player1UR);
        playerB.updateRating(player2UR);
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("result") as! ResultController;
        
        if(player1SR > player2SR)
        {
            vc.players = [playerA,playerB];
        }else
        {
            vc.players = [playerB,playerA];
        }
        
        
        //let navigationcontroller = UINavigationController.init(rootViewController: vc)
        
        
       // self.presentViewController(navigationcontroller, animated: true, completion: nil);
        
        
        
       // self.navigationController!.presentViewController(navController, animated: true, completion: nil)

        
        self.navigationController?.pushViewController(vc, animated: true)
  
    }
    
    

    
    func getResultOfMatch() -> MatchResult
    {
        let randomNumber = Int(arc4random_uniform(3) + 1);
        
        if(randomNumber == 1){
            print("Player A won");
            return MatchResult.playerAWins
        }
        else if(randomNumber == 2){
            print("Player B won");
            return MatchResult.playerBWins
        }
        else{
            print("match Dawn");
            return MatchResult.matchDrawn
        }
        
        
        
    }


}

