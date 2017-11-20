//
//  Networking.swift
//  movsea
//
//  Created by Movsea Team on 5/6/16.
//  Copyright © 2017 Movsea Team.
//

import Alamofire
import RealmSwift
import ObjectMapper

class Networking {
    
    var alamofireManager : SessionManager?
    
    static let sharedInstance : Networking = {
        let instance = Networking()
        return instance
    }()

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5600 // seconds
        configuration.timeoutIntervalForResource = 5600 // seconds
        
        self.alamofireManager = SessionManager(configuration: configuration)
    }
    
    
    func porcessMovie(_ complition: @escaping (Result<Movie>) -> Void) -> Request? {
       
        guard let serverUrl = UserDefaults.standard.string(forKey: "server-url") else {
            let error = self.error(failureReason: "No Server Url Provided")
            complition(.failure(error))
            return nil
        }
        
        if !FileManager.default.fileExists(atPath: FileManager.getSavedOutput().path) {
            let error = self.error(failureReason: "No output movie founded")
            complition(.failure(error))
            return nil
        }
    
        guard let request = alamofireManager?.upload(FileManager.getSavedOutput(), to: serverUrl) else { return nil }
        request.responseJSON { response in
            switch response.result {
                case .success(let JSON):                        
                    guard let movie = Mapper<Movie>().map(JSONObject: JSON) else {
                        let error = self.error(failureReason: "Parsing error")
                        complition(.failure(error))
                        return
                    }
                    let realm = try! Realm()
                    try! realm.write {
                        movie.syncDate = Date()
                        realm.add(movie)
                    }
                    print("movie response - \(movie)")
                    complition(.success(movie))
                case .failure:
                    print("fail - \(String(describing: response.result.error))")
                    if let error = response.result.error {
                        complition(.failure(error))
                    } else {
                        let error = self.error(failureReason: "Not Found")
                        complition(.failure(error))
                    }
                }
            }
        
        return request
    }
    
    func sendFeedback(subject: String, message: String, complition: @escaping (Result<Bool>) -> Void) {
        
        guard let serverUrl = UserDefaults.standard.string(forKey: "server-url") else {
            let error = self.error(failureReason: "No Server Url Provided")
            complition(.failure(error))
            return
        }
        
        let parameters = ["subject": subject, "message": message]
        
        alamofireManager?.request(serverUrl+"/someAPI", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .success( _):
                    complition(.success(true))
                case .failure:
                    print("fail - \(String(describing: response.result.error))")
                    if let error = response.result.error {
                        complition(.failure(error))
                    } else {
                        let error = self.error(failureReason: "Something went wrong")
                        complition(.failure(error))
                    }
                }

            }
    
    }
 
    func sendFilmStats(movie: Movie, statistic: Bool) {
        guard let serverUrl = UserDefaults.standard.string(forKey: "server-url") else {
            //let error = self.error(failureReason: "No Server Url Provided")
            return
        }
        
        let parameters = ["movie": movie.id, "statistic": statistic] as [String : Any]
        
        alamofireManager?.request(serverUrl+"/someAPI", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .success( _):
                    print("success - \(String(describing: response.result.value))")
                case .failure:
                    print("fail - \(String(describing: response.result.error))")
                }
                
        }
    }
    
    private func error(domain: String = "movsea.com.NetworkError", code: Int = -1, failureReason: String) -> NSError {
        let userInfo: Dictionary<String, String> = [NSLocalizedFailureReasonErrorKey: failureReason]
        return NSError(domain: domain, code: code, userInfo: userInfo)
    }
}
