//
//  HttpRequest.swift
//  TenThings
//
//  Created by Kitty Katt on 7/13/17.
//  Copyright © 2017 kohler. All rights reserved.
//

import UIKit

class HttpRequest: NSObject {

    //                    print("ASynchronous\(jsonResult)")

    static func basicGet(to url:String, withCallBack closure: (_ jsonResult:String) -> ()){
        let request = NSMutableURLRequest(url: URL(string: "http://127.0.0.1:8000")!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest) {data,response,error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    closure(jsonResult)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        dataTask.resume()
    }
}
