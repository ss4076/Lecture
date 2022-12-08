//
//  ViewModel.swift
//  AsyncTest
//
//  Created by djpark on 2022/03/08.
//

import Foundation
import RxSwift
import RxCocoa

struct RESULT {
    var code = 0
    var message = ""
}
class ViewModel {
    
    var onUpdate:() -> Void = {}
    let service = Service()
    
    let idString = BehaviorRelay<String>(value: "")   // 옵저버블
    let pwString = BehaviorRelay<String>(value: "")   // 옵저버블
    
    
    
    var userList:[String] = []
    var userObservable = BehaviorSubject<[String]>(value: [])
    
    init() {
        userObservable.onNext(userList)
    }
    
    var isValid:Observable<Bool> {
        return Observable.combineLatest(idString, pwString)
            .map { id, pw in
                print("id: \(id), pw: \(pw)")
                return id.count > 0 && pw.count > 0
            }
    }
    
    func login(id: String, pw: String)-> Observable<RESULT> {
        
        return Observable.create() { emmiter in
        
            self.service.login(onCompleted: {[weak self] message in
                guard self != nil else { // false면 동작함
                    return
                }
                
                print("login id: \(id)")
//                print("login pw: \(pw)")
                var result = RESULT()
                result.code = 0
                result.message = NSLocalizedString("SUCCESS", comment: "SUCCESS")
                self?.userList.append(id)
                self?.userObservable.onNext(self!.userList)
                emmiter.onNext(result)
                emmiter.onCompleted()
                
            })
            return Disposables.create()
            
        }
    }
}
