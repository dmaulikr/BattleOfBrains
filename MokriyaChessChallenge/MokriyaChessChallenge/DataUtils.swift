//
//  DataUtils.swift
//  MokriyaChessChallenge
//
//  Created by Raja Ayyan on 23/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import Foundation

class DataUtils{
    static func generateRandomNumber(n: UInt32) -> Int{
        let randomnumber = Int(arc4random_uniform(n))
        return randomnumber
    }
}