//
//  NetworkOperation.swift
//  MokriyaChessChallenge
//
//  Created by Raja Ayyan on 23/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import Foundation

class NetworkOperation {
    
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL: NSURL
    
    typealias jsonData = ( NSData -> Void)
    
    init(url: NSURL) {
        self.queryURL = url
    }
    
    func getData(errorHandler: (String) -> (),completion: jsonData){
        
        let request = NSURLRequest(URL: self.queryURL)
        
        let datatask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                errorHandler((error?.description)!)
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                errorHandler("status code is other than 200")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                errorHandler("Data is not present")
                return
            }
            
            completion(data)
            
        }
        
        datatask.resume()
        
    }
    
}