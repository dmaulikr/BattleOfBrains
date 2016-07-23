//
//  DashBoardController.swift
//  BattleOfBrains
//
//  Created by administrator on 23/07/16.
//  Copyright © 2016 phani_practice. All rights reserved.
//
import UIKit

class DashboardController: UIViewController, DashboardDelegate, UIAdaptivePresentationControllerDelegate{
    
    let players:[PlayerModal];
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, _ players:[PlayerModal]) {
        
        self.players = players;
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dashboard:DashBoardView = DashBoardView.init(frame:CGRectZero);
    
    override func loadView() {
    
        self.dashboard.drawDashBoard(players)
        self.view = dashboard
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None;
        self.extendedLayoutIncludesOpaqueBars = false;
        self.automaticallyAdjustsScrollViewInsets = false;
        
        dashboard.dashboardDelegate = self;
        
        self.title = "Player statstics after match";
    
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showPopup(viewController: UIViewController) {
        viewController.presentationController?.delegate = self;
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .None
    }
    
    
}


