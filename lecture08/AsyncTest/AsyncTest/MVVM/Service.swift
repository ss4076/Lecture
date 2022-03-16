//
//  Service.swift
//  AsyncTest
//
//  Created by djpark on 2022/03/08.
//

import Foundation

class Service {
    
    let repository = Repository()
    var currentModel = Model(currentDateTime: Date())
    
    
    func login(onCompleted:@escaping(String?)->Void) {
        repository.login { [weak self] message in
            print("Service login ")
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
//
//            guard let now = formatter.date(from: entity.currentDateTime) else { return }
//
//            let model = Model(currentDateTime: now)
//            self?.currentModel = model
            onCompleted(message)
         }
    }
}
