//
//  HttpRequest.swift
//  TenThings
//
//  Created by Kitty Katt on 7/13/17.
//  Copyright © 2017 kohler. All rights reserved.
//

import UIKit

class HttpRequestHelper: NSObject {
    
    //TODO - handle http 404 errors
    //TODO - handle cookie

    static func preformBasicPost(to apiEndpoint:String, withCallBack closure: @escaping (_ httpUrlResponse:HTTPURLResponse?, _ jsonResult:NSDictionary?) -> Void, sendData postString:String, withErrorHandler failureClosure: @escaping(_ error:NSError) -> Void) -> Void{
        var request = URLRequest(url: URL(string: apiEndpoint)!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: .utf8)
        
        let session = URLSession.shared

        let dataTask = session.dataTask(with: request, completionHandler: {(data:Data?, urlResponse:URLResponse? ,error:Error?) -> Void in

            let httpUrlResponse = urlResponse as? HTTPURLResponse
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    closure(httpUrlResponse, jsonResult)
                }
            }
            catch let error as NSError {
                failureClosure(error)
            }
        })
        
        dataTask.resume()
    }
    
    
    static func preformBasicGet(to apiEndpoint:String, withCallBack closure: @escaping (_ jsonResult:NSDictionary) -> Void){
        let request = NSMutableURLRequest(url: URL(string: apiEndpoint)!)
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
