//
//  NetworkManager.swift
//  KeyPointTask
//
//  Created by Jagadeesh on 06/07/24.
//

import Foundation

class HttpClient: NSObject {
    static let shared = HttpClient()
    
    func getDataFromURL(url: String, completion: @escaping (_ data: Data?, _ error: NSError?) -> ()) {
        guard let urlStr = URL(string: url) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(nil, error)
            return
        }
        
        var request = URLRequest(url: urlStr)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error as NSError)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCodeError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unexpected response code"])
                completion(nil, statusCodeError)
                return
            }
            
            completion(data, nil)
        }
        task.resume()
    }

}
