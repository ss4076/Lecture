//
//  Repository.swift
//  AsyncTest
//
//  Created by djpark on 2022/03/08.
//

import Foundation
 
class Repository {
    
    func login(onCompleted:@escaping(String?) -> ()) {
        
        // login url로 변경
        let url = "http://worldclockapi.com/api/json/utc/now"
        
        URLSession.shared.dataTask(with: URL(string:url)!) { [weak self] data, response, error in
            
            
            guard let data = data else {
                return
            }
            
            guard let model = try? JSONDecoder().decode(ServiceModel.self, from: data) else {    // false면 실행
                    return
            }
            print("repository login: \(model.currentDateTime) ")
            
            onCompleted("success")
            
                    
        }.resume()
    }
}
