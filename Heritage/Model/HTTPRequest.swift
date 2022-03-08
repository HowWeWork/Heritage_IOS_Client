//
//  HTTPRequest.swift
//  Heritage
//
//  Created by HappyDuck on 2022/03/07.
//

import UIKit


//func getRequest() {
//    //Create URL
//    let url = URL(string: "http://192.168.5.31:5000/board")
//    guard let requestUrl = url else { fatalError() }
//
//    //Create URL Request
//    var request = URLRequest(url: requestUrl)
//
//    //Specify HTTP Method to use
//    request.httpMethod = "GET"
//
//    //Set HTTP Request Header : no need
//
//    //Send HTTP Request
//
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        if let error = error {
//            print("Error took place \(error)")
//            return
//        }
//        // Read HTTP Response Status code
//        if let response = response as? HTTPURLResponse {
//            print("1.Response HTTP Status code: \(response.statusCode)")
//
//        }
//
//        // Convert HTTP Response Data to a simple String
//        guard let data = data else { return }
//
//        do {
//            let posts = try JSONDecoder().decode([Data].self, from: data)
//            JSONData = posts
//            
////
////            for i in 0...(posts.count - 1) {
////                JSONData.append(posts[i])
////            }
////            print("Number of data we have: \(JSONData.count)")
//        } catch {
//            print(error.localizedDescription)
//        }
//        print(JSONData)
//    }
//    task.resume()
//}


func postRequest(userName: String, pw: String, sector: String, title: String, comment: String) {
    guard let url = URL(string: "http://192.168.5.31:5000/board") else {
        return
    }
  
    // Prepare URL Request Object
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
     
    // HTTP Request Parameters which will be sent in HTTP Request Body
//    let postString = "userId=300&title=My urgent task&completed=false";
    // Set HTTP Request Body

    let body: [String: AnyHashable] = [
        
        "userName": userName,
        "pw": pw,
        "sector": sector,
        "title": title,
        "comment": comment
        
    ]

    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

    // Perform HTTP Request
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
    }
    task.resume()
    
}
