//
//  SCConnectionManager.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 10/21/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit

typealias CompletionHandler = () -> Void

class SCConnectionManager: NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate, URLSessionDownloadDelegate, URLSessionStreamDelegate {
    
    static let shared = SCConnectionManager()

    private var recievedData : Data?
    var completionHandlers: [String: CompletionHandler] = [:]

    let mainSessionConfiguraition = URLSession(configuration: .default, delegate: shared, delegateQueue: OperationQueue.main)
    let backgroundSessionConfiguration = URLSession(configuration: .background(withIdentifier: "backgroundSession"), delegate: shared, delegateQueue: OperationQueue.main)
    let ephemeralSessionConfiguration = URLSession(configuration: .ephemeral, delegate: shared, delegateQueue: OperationQueue.main)
    
    // MARK: URLSessionDelegate
    
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        //Handle error here
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust:challenge.protectionSpace.serverTrust!))
    }
    
    // MARK: URLSessionTaskDelegate
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        //
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        //
    }
    
    // MARK: URLSessionDataDelegate
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            print("Error")
            return
        }
        
        print(json)
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
    }
    
}
