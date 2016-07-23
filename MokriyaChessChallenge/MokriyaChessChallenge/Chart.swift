//
//  ColumnGraph.swift
//  Chart
//
//  Created by Phani on 09/11/15.
//  Copyright © 2015 MetricStream. All rights reserved.
//

import UIKit

protocol ChartDelegate{
    func showPopup(viewController:UIViewController)
}

class Chart: UIView, DisplayViewDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var startX:CGFloat = 0
    var startY:CGFloat = 0
    var legendSpace:CGFloat = 0
    
    let yaxis:YAxis,xaxis:XAxis,displayView:DisplayView,legendView:LegendView,titleView:UILabel
    let colors = ReadColorsBundle.instance.getColors()
    var chartDelegate:ChartDelegate?

    
    init(frame: CGRect, graph: ChartTypesEnum,data:[String:[String:ChartUnitData]],axisValues:[String],colorValues:[String],xAxisName:String,yAxisName:String, title: String) {
        
        var high:CGFloat = 0.0;
        var low:CGFloat = 1000.0;
        
        for (_ , values ) in data
        {
            
            for (_ , graphUnit ) in values
            {
                if( graphUnit.value > high)
                {
                    high = graphUnit.value
                }
                
                if( graphUnit.value < low)
                {
                    low = graphUnit.value
                }
                
            }
            
        }
        
        
        var num = 1;
        
        while(CGFloat(num) < high)
        {
            num = num * 10;
        }
        
        if(num > 10 )
        {
            num = num / 10 ;
        }
        
        
        var remain = Int(high / CGFloat(num))+1 ;
        high =  CGFloat (remain * num);
        
        high = high + CGFloat(num);
        
        while(CGFloat(num) > low)
        {
            num = num/10;
        }
        
        remain = Int(low / CGFloat(num));
        low = CGFloat (remain * num);
        
        if(graph == ChartTypesEnum.Column)
        {
            low = 0;
        }
        
        
        yaxis = YAxis.init(frame: CGRectZero, low: low, high: high, units:5)
        xaxis = XAxis.init(frame: CGRectZero, data: axisValues)
        
        displayView = ChartFactory.instance.createGraph(graph)
        
        displayView.data = data;
        displayView.highValue = high;
        displayView.lowValue = low;
        displayView.xAxisKeys = axisValues;
        displayView.colorKeys = colorValues;
        displayView.xAxisName = xAxisName;
        
        titleView = UILabel.init(frame: CGRectZero);
        titleView.textAlignment = NSTextAlignment.Center;
        
        titleView.text = title;
        
        legendView = LegendView.init(frame: CGRectZero, data: colorValues,colors:colors);
        super.init(frame: frame)
        
        displayView.delegate = self;
        
        self.addSubview(xaxis);
        self.addSubview(yaxis);
        self.addSubview(displayView);
        self.addSubview(legendView);
        self.addSubview(titleView);
        
        setSize()

        
    }

    required init?(coder aDecoder: NSCoder) {
        yaxis = YAxis.init(coder: aDecoder)!
        xaxis = XAxis.init(coder: aDecoder)!
        displayView = DisplayView.init(coder: aDecoder)!
        legendView = LegendView.init(coder: aDecoder)!
        titleView = UILabel.init(coder: aDecoder)!
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        
       /* let startX:CGFloat = 80
        let startY:CGFloat = 75
        let legendSpace:CGFloat = 60 */
        
       /* let startX:CGFloat = 63
        let startY:CGFloat = 60
        let legendSpace:CGFloat = 50 */
        
        let endX = self.frame.size.width - startX - 5
        let endY:CGFloat = self.frame.size.height-startY-60-legendSpace;
        
        displayView.frame = CGRect(x: startX, y:startY, width:endX, height:endY)
        yaxis.frame = CGRect(x: 0, y:startY-8, width: startX, height:endY+16)
        xaxis.frame = CGRect(x:startX, y:startY+endY, width:endX, height:60)
        legendView.frame = CGRect(x:startX, y:self.frame.size.height-legendSpace+5, width:self.frame.size.width-startX-5, height:legendSpace-10);
        titleView.frame = CGRect(x:0, y:20, width:self.frame.size.width, height:40);
        
        let layer = CALayer.init();
        layer.backgroundColor = UIColor.init(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0).CGColor;
        layer.frame = CGRectMake(0, CGRectGetHeight(self.frame)-1.0, CGRectGetWidth(self.frame), 1.0);
        
        self.layer.addSublayer(layer);
    }
    
    func showPopup(viewController: UIViewController) {
        chartDelegate!.showPopup(viewController);
    }
    
    func setSize() {
        
        let deviceType = UIDevice.currentDevice()
        
        if let path = NSBundle.mainBundle().pathForResource("Size", ofType: "plist"),
            dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
                
                let iPhoneComponents = dict[deviceType.model] as? Dictionary<String, AnyObject>
                let componentSizes = iPhoneComponents!["Chart"] as? Dictionary<String, AnyObject>
                let startX: Int = (componentSizes!["startX"] as? Int)!
                let startY: Int = (componentSizes!["startY"] as? Int)!
                let legendSpace: Int = (componentSizes!["legendSpace"] as? Int)!
                
                self.startX = CGFloat(startX)
                self.startY = CGFloat(startY)
                self.legendSpace = CGFloat(legendSpace)
                
        }
    }
}
