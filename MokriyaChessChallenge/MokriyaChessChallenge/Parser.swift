//
//  Parser.swift
//  Chart
//
//  Created by Phani on 29/02/16.
//  Copyright © 2016 MetricStream. All rights reserved.
//

import UIKit

class Parser: NSObject {
    
    func parseElementsForColumn(players:[PlayerModal]) -> ([String:[String:ChartUnitData]],[String],[String])
    {
        var axisKeys = [String]();
        var colorKeys = ["Current", "Previous"];
        var data:[String:[String:ChartUnitData]] = [String:[String:ChartUnitData]]();
        
        for(player) in players
        {
            var arryValues = [String:ChartUnitData]()
            for i in 0...1
            {
                if(i > player.previousRatings.count - 1)
                {
                    break;
                }
                let value = player.previousRatings[i];
                let colorKey = colorKeys[i];
                let graphUnit = ChartUnitData.init(xname: player.name, yname: colorKey, colorName:colorKey, value: CGFloat(value));
                
                arryValues[colorKey] = graphUnit
            }
            axisKeys.append(player.name);
            data[player.name] = arryValues;
        }
        
        //playerA data
        return (data,axisKeys,colorKeys);
        
        
    }
    
    func parseElementsForLine(players:[PlayerModal]) -> ([String:[String:ChartUnitData]],[String],[String])
    {
        var axisKeys = [String]();
        var colorKeys = [String]();
        var data:[String:[String:ChartUnitData]] = [String:[String:ChartUnitData]]();
        
        for i in (0..<5)
        {
            
            var axisKey = "This Match"
            
            if(i > 0)
            {
                if(i == 1)
                {
                    axisKey = "Last Match"
                    
                }else
                {
                    axisKey = "Last Match - \(i-1)"
                }
            }
            
            axisKeys.append(axisKey);
        }
        
        for(index,axisKey) in axisKeys.enumerate()
        {
            var arryValues = [String:ChartUnitData]()
            for (player) in players
            {
                if(index > player.previousRatings.count - 1)
                {
                    break;
                }
                
                let value = player.previousRatings[index];
                
                let colorKey = player.name;
                let graphUnit = ChartUnitData.init(xname: player.name, yname: colorKey, colorName:colorKey, value: CGFloat(value));
                
                arryValues[colorKey] = graphUnit;
                
                if(!colorKeys.contains(colorKey))
                {
                    colorKeys.append(colorKey);
                }
                
            }
            
            data[axisKey] = arryValues;
        }
        
        axisKeys = axisKeys.reverse();
        
        return (data,axisKeys,colorKeys);
    
    }
    
    func parseElementsForPie(players:[PlayerModal]) -> ([String:ChartUnitData],[String])
    {
        
        var pieData:[String:ChartUnitData] = [String:ChartUnitData]();
        var axisKeys:[String] = [String]();
        
        var total = 0.0;
        for(player) in players
        {
            total += player.currentRating;
        }
        
        for player in players
        {
            let value = Int(player.currentRating/total * 100);
            
            let axisKey = player.name + " - \(value)%"
            let graphUnit = ChartUnitData.init(xname: axisKey, yname: "Win percentage", colorName:player.name, value: CGFloat(value));
            pieData[axisKey] = graphUnit;
            
            axisKeys.append(axisKey);
        }
        
        return (pieData,axisKeys);
        
    }

    
}