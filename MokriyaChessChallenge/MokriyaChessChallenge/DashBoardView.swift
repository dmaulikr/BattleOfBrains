//
//  DashBoardView.swift
//  Chart
//
//  Created by Phani on 17/11/15.
//  Copyright © 2015 MetricStream. All rights reserved.
//

import UIKit

protocol DashboardDelegate{
    func showPopup(viewController:UIViewController)
}

class DashBoardView: UIScrollView,ChartDelegate, pieDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var charts:[UIView] = [UIView]();
    var dashboardDelegate:DashboardDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func drawDashBoard(players:[PlayerModal]) {

        let parser = Parser.init();
        let (columnData,columnAxisKeys,columnColorKeys) = parser.parseElementsForColumn(players);
        let columnChart = Chart.init(frame: CGRectZero, graph: ChartTypesEnum.Column,data:columnData,axisValues:columnAxisKeys,colorValues:columnColorKeys,xAxisName:"Players", yAxisName:"Ratings", title: "Players rating after match")
        
        columnChart.chartDelegate = self;
        
        
        let (lineData,lineAxisKeys,lineColorKeys) = parser.parseElementsForLine(players);
        
        let lineChart = Chart.init(frame: CGRectZero, graph: ChartTypesEnum.Line,data:lineData,axisValues:lineAxisKeys,colorValues:lineColorKeys,xAxisName:"last 5 matches",yAxisName:"Ratings", title: "Player rating trend over last five matches")
        lineChart.chartDelegate = self;
        
        let (pieData,axiskeys) = parser.parseElementsForPie(players);
        let pieChart = PieChart.init(frame: CGRectZero, data: pieData, colorValues: axiskeys, xAxisName: "Winning Chance", yAxisName: "Probability of winning", title: "Probability of winning")
        
        self.addSubview(pieChart)
        self.addSubview(columnChart)
        self.addSubview(lineChart)
        
        charts.append(columnChart)
        charts.append(lineChart)
        charts.append(pieChart);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
    
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        
        let width = self.frame.size.width;
        var height:CGFloat  = self.frame.size.height/2;
    
        let deviceType = UIDevice.currentDevice();
        
        if(width > self.frame.size.height && deviceType.model == "iPhone")
        {
            height = self.frame.size.height;
        }
        
        self.contentSize  = CGSizeMake(width, 3*height);
        
        var index:CGFloat=0;
        for view in self.charts
        {
            view.frame = CGRectMake(0, index * height, width, height);
            index = index + 1;
        }
        
//        if(width>height)
//        {
//            
//            self.contentSize  = CGSizeMake(2 * width, height);
//            
//            var index:CGFloat=0;
//            for view in self.charts
//            {
//                view.frame = CGRectMake(index * width, 0, width/2, height);
//                index = index + 0.5;
//            }
//        
//            
//        }else
//        {
//            self.contentSize  = CGSizeMake(width, 2 * height)
//            var index:CGFloat=0;
//            for view in self.charts
//            {
//                view.frame = CGRectMake(0, index * height, width, height/2);
//                index = index + 0.5;
//            }
//        }
        
        
    }
    
    func showPopup(viewController: UIViewController) {
        dashboardDelegate!.showPopup(viewController);
    }
}
