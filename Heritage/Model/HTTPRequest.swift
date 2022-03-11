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
    guard let url = URL(string: "http://heritage-env-1.eba-dvm4baup.ap-northeast-2.elasticbeanstalk.com/board") else {
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

//PATCH
func patchRequest(boardNum: Int, sector: String, title: String, comment: String, completed: @escaping () -> ()) {
    guard let url = URL(string: "http://heritage-env-1.eba-dvm4baup.ap-northeast-2.elasticbeanstalk.com/board/\(boardNum)") else { return }
    
    struct UploadData: Codable {
        var sector: String
        var title: String
        var comment: String
    }
    
    let uploadDataModel = UploadData(sector: sector, title: title, comment: comment)
    
    guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
        print("Error: Trying to convert model to JSON data")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PATCH"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard error == nil else {
            print("Error: error calling PUT")
            return
        }
        guard let data = data else {
            print("Error: Did not receive data")
            return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        do {
            guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                print("Error: cannot convert data to JSON object")
                return
            }
            guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                print("Error: Cannot convert JSON object to Pretty JSON data")
                return
            }
            guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                
                print("Error: Could print JSON in String")
                return
            }
            
            print(prettyPrintedJson)
        } catch {
            print("Error: Trying to convert JSON data to string")
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            completed()
        }) 
        
    }.resume()
}

//Like PATCH
func likePatchRequest(boardNum: Int, likeCount: Int, completed: @escaping () -> ()) {
    guard let url = URL(string: "http://heritage-env-1.eba-dvm4baup.ap-northeast-2.elasticbeanstalk.com/board/\(boardNum)") else { return }
    
    struct UploadData: Codable {
        var likeCount: Int
    }
    
    let uploadDataModel = UploadData(likeCount: likeCount)
    
    guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
        print("Error: Trying to convert model to JSON data")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PATCH"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard error == nil else {
            print("Error: error calling PUT")
            return
        }
        guard let data = data else {
            print("Error: Did not receive data")
            return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        do {
            guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                print("Error: cannot convert data to JSON object")
                return
            }
            guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                print("Error: Cannot convert JSON object to Pretty JSON data")
                return
            }
            guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                
                print("Error: Could print JSON in String")
                return
            }
            
            print(prettyPrintedJson)
        } catch {
            print("Error: Trying to convert JSON data to string")
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            completed()
        })
        
    }.resume()
}

//DELETE
func deleteRequest(boardNum: Int, completion: @escaping (Error?) -> ()) {
    guard let url = URL(string: "http://heritage-env-1.eba-dvm4baup.ap-northeast-2.elasticbeanstalk.com/board/\(boardNum)") else { return }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "DELETE"
    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        if let error = error {
            completion(error)
            return
        }
        guard let data = data else { return }
        completion(nil)
    }.resume()
}





