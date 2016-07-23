//
//  HomeScreenController.swift
//  MokriyaChessChallenge
//
//  Created by Raja Ayyan on 23/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import UIKit

class HomeScreenController: UIViewController, UIPageViewControllerDataSource{
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var playButton: UIButton!
    let appdelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    lazy var coredataapi = CoreDataAPI()
    
    
    
    var controllersCount: Int?
    var pageViewController:UIPageViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coredataapi = CoreDataAPI()
        
        
        
        
        
        let offset = getNumberOfCellsToFitOnScreen()
        print("\(getNumberOfCellsToFitOnScreen())")
        let playerscount = coredataapi.getCountOfPlayers(PLAYERS_TABLE)
        self.controllersCount = (playerscount + (offset - 1)) / offset
        
        if self.getData().count > 0{
            self.loadPaginationControllerToContainerView()
        }else{
            self.getDataFromServer()
        }
        
        
    }
    
    
    func getDataFromServer(){
        
        let url = NSURL(string: CHESS_PLAYERS_URL)
        let networkOperation = NetworkOperation(url: url!)
        networkOperation.getData({ (error) in
            //handle Error
        }) { (data) in
            //handle sucess Data
            let parser = ChessPlayerParser(data: data)
            parser.parseData()
            self.loadPaginationControllerToContainerView()
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func playAction(sender: AnyObject) {
        
        if appdelegate!.selectedPlayers.count >= 2{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let playingvc = storyboard.instantiateViewControllerWithIdentifier(Storyboard_Constants.PLAYING_VC) as! PlayingController;
            playingvc.player1 = appdelegate?.selectedPlayers[0]
            playingvc.player2 = appdelegate?.selectedPlayers[1]

            let navigatincont = UINavigationController.init(rootViewController: playingvc)
            
            UINavigationBar.appearance().barTintColor =  UIColor(colorLiteralRed: 255/255, green: 45/255, blue: 85/255, alpha: 1.0)
            UINavigationBar.appearance().tintColor = UIColor.whiteColor()
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]

            
            self.presentViewController(navigatincont, animated: true, completion: nil);
            
            
        }
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}


extension HomeScreenController{
    func loadPaginationControllerToContainerView(){
        
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier(Storyboard_Constants.PAGINATION_CONTROLLER_ID) as! UIPageViewController
        self.pageViewController.dataSource = self
        self.pageViewController.view.backgroundColor = UIColor(colorLiteralRed: 142/255, green: 142/255, blue: 147/255, alpha: 1.0)
        
        self.pageViewController.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height)
        
        let initialContenViewController = self.playerControllerAtIndex(0)
        let viewControllers = NSArray(object: initialContenViewController)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        self.containerView.addSubview(self.pageViewController.view)
        
        
    }
}


//MARK: Player Logic

extension HomeScreenController{
}


//MARK: PaginationController Delegate Methods


extension HomeScreenController{
    
    func playerControllerAtIndex(index: Int) -> HomeScreenTable
    {
        
        let start = index * 5
        let end = (index+1) * 5
        var chessplayer: [PlayerModal] = []
        
        if let players = self.getData(){
            
            if players.count > 0{
                for index in start..<end{
                    let eachPlayer = players[index] as? ChessPlayers
                    
                    let rating = eachPlayer!.currentrating as? Double
                    let imagenames: [String] = ["carlson","kamnik","kasparov-1","kasparov","viswanathanand","wesley"]
                    
                    let imageIndex =  index % imagenames.count;
                    
                    let player = PlayerModal(name: eachPlayer!.name!, withRating: rating!, withHistory: [rating!], imagename: imagenames[imageIndex])
                    
                    
                    chessplayer.append(player)
                    
                }
                
                
            }
            
        }
        
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier(Storyboard_Constants.HOMESCREEN_TABLE_CONTROLLER) as! HomeScreenTable
        pageContentViewController.pageIndex = index
        pageContentViewController.players = chessplayer
        return pageContentViewController
        
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! HomeScreenTable
        var index = viewController.pageIndex as Int
        
        if(index == 0 || index == NSNotFound)
        {
            return nil
        }
        
        index = index - 1
        
        return self.playerControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! HomeScreenTable
        var index = viewController.pageIndex as Int
        
        if((index == NSNotFound))
        {
            return nil
        }
        
        index = index + 1
        
        if(index == self.controllersCount)
        {
            return nil
        }
        
        return self.playerControllerAtIndex(index)
    }
    
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return self.controllersCount!
    }
    
    
    
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
    
    
    func getData() -> [ChessPlayers]!{
        
        let coredataapi = CoreDataAPI()
        if let players = coredataapi.getDataFromEntity(PLAYERS_TABLE) as? [ChessPlayers]{
            return players
        }else{
            return nil
        }
        
        
    }
    
    
    func getNumberOfCellsToFitOnScreen() -> Int{
        let heighofContainer = self.containerView.frame.size.height - 20
        let cellHieght = CGFloat(80)
        
        return Int(heighofContainer/cellHieght)
    }
    
    
}




