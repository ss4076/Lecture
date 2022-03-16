//
//  ViewController.swift
//  AsyncTest
//
//  Created by dong jun park on 2022/03/04.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftUI




/**
 Ropository
 Entity (서버 Model) -> UTCTimeModel
 Mapper
 
 
 Model -> Date
 Logic
 
 ViewModel (화면 Model) -> String
 View
 
 */

class 나중에생기는데이터<T> {
    
    private let task:(@escaping(T) -> Void) -> Void
    
    init (task: @escaping(@escaping(T) -> Void) -> Void) {
        self.task = task
    }
    func 나중에오면(_ f: @escaping(T) -> Void) {
        task(f)
    }
}

//extension ViewController: UITableViewDelegate, UITableViewDataSource  {
//    
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.viewModel.userList.count
//    }
//    
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text =  self.viewModel.userList[indexPath.row]
//
//        return cell
//    }
//}

class ViewController: UIViewController {

    @IBOutlet weak var idTextFiled: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var userList: UITableView!
    
    private var disposeBag = DisposeBag()
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        viewModel.userObservable
            .observeOn(MainScheduler.instance)
            .bind(to:userList.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { index, item, cell in
                
//                print(NSLocalizedString("LOGIN", comment: "LOGIN"))
                cell.textLabel?.text = item
            }.disposed(by: disposeBag)
        
        idTextFiled.rx.text
            .orEmpty
            .bind(to: viewModel.idString)
            .disposed(by: disposeBag)

        pwTextField.rx.text
            .orEmpty
            .bind(to: viewModel.pwString)
            .disposed(by: disposeBag)
        
        
        viewModel.isValid
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        
        viewModel.isValid
            .map { $0 ? 1 : 0.3}
            .bind(to: loginButton.rx.alpha)
            .disposed(by: disposeBag)
                    
//        self.idTextFiled.rx.controlEvent([.editingChanged])
//            .asObservable()
//            .subscribe(onNext: {
//                print(self.idTextFiled.text!)
//            }, onCompleted: {
//                print("completed")
//            })
//            .disposed(by: disposeBag)
//
//        self.pwTextField.rx.controlEvent([.editingChanged])
//            .asObservable()
//            .subscribe(onNext: {
//                print(self.pwTextField.text!)
//            }, onCompleted: {
//                print("completed")
//            })
//            .disposed(by: disposeBag)
        
        
        self.loginButton.rx.tap
            .subscribe(onNext: {
                self.setActivityIndicator(true)
                
                _ = self.viewModel.login(id: self.idTextFiled.text!, pw: self.pwTextField.text!)
                    .subscribe(onNext: {result in
                        print(result.code)
                        print(result.message)
                    }, onCompleted: {
                        print("completed")
                        DispatchQueue.main.async {
                            self.idTextFiled.text=""
                            self.pwTextField.text=""
                            let hostingController = UIHostingController(rootView: SwiftUIView())
                            self.present(hostingController, animated: true, completion: nil)
                            
                            self.setActivityIndicator(false)
                        }
                })
            })
            .disposed(by: disposeBag)
    }

//    func downloadImage(url: String, completion:@escaping(UIImage?) -> ()) {
//
//        DispatchQueue.global().async {
//            let url = URL(string: self.IMAGE_URL)!
//            let data = try! Data(contentsOf: url)
//            let image = UIImage(data: data)
//            DispatchQueue.main.async {
//                completion(image)
//            }
//        }
//    }
//
//    func downloadImage(url: String) -> 나중에생기는데이터<UIImage?> {
//
//        return 나중에생기는데이터() { f in
//            DispatchQueue.global().async  {
//                let url = URL(string: self.IMAGE_URL)!
//                let data = try! Data(contentsOf: url)
//                let image = UIImage(data: data)
//
//                DispatchQueue.main.async {
//                    f(image)
//                }
//            }
//        }
//    }
//
//    func downloadImage(url: String) -> Observable<UIImage?> {
//
//        return Observable.create() { f in
//            DispatchQueue.global().async  {
//                let url = URL(string: self.IMAGE_URL)!
//                let data = try! Data(contentsOf: url)
//                let image = UIImage(data: data)
//
//                DispatchQueue.main.async {
//                    f.onNext(image)
//                    f.onCompleted()
//                }
//            }
//            return Disposables.create()
//        }
//    }
//
//    func downloadImageRx(url: String) -> Observable<UIImage?> {
//
//        return Observable.create() { emmiter in
//            let url = URL(string: self.IMAGE_URL)!
//
//            let task = URLSession.shared.dataTask(with: url) {(data
//                , _, err) in
//                guard err == nil else { // 조건이 false일때 아래 코드 실행됨
//                    emmiter.onError(err!)
//                    return
//                }
//
//                let image = UIImage(data: data!)
//
//                emmiter.onNext(image)
//                emmiter.onCompleted()
//            }
//
//            task.resume()
//
//            return Disposables.create() {
//                task.cancel()
//            }
//        }
//    }
//
//
    func setActivityIndicator(_ isActive: Bool) {

        activeIndicator.isHidden = !isActive
        activeIndicator.isHidden ? activeIndicator.stopAnimating(): activeIndicator.startAnimating()
    }
    
    
    /**
     Observable의 생명주기
     1. Create
     2. Subscribe
     3. onNext
     -------------------
     4. onCompletd / onError
     5. Disposed
     */
    @IBAction func onLoad(_ sender: Any) {
        
        // UIKit 사용
//        setActivityIndicator(true)
//        downloadImage(url: IMAGE_URL) { image in
//            self.imageView.image = image
//            self.activeIndicator.stopAnimating()
//            let hostingController = UIHostingController(rootView: SwiftUIView())
//            self.present(hostingController, animated: true, completion: nil)
//        }
        
        // RxSwift 따라하기
//        setActivityIndicator(true)
//        let image: 나중에생기는데이터<UIImage?> = downloadImage(url: IMAGE_URL)
//        _ = image.나중에오면 { image in
//            self.imageView.image = image
//            self.setActivityIndicator(false)
//            let hostingController = UIHostingController(rootView: SwiftUIView())
//            self.present(hostingController, animated: true, completion: nil)
//        }
        
        // RxSwift 사용
//        setActivityIndicator(true)
//        let image: Observable<UIImage?> = downloadImage(url: IMAGE_URL)
//        _ = image.subscribe { event in
//            switch event {
//            case .next(let image):
//                self.imageView.image = image
//                self.setActivityIndicator(false)
//            case .completed:
//                break
//            case .error:
//                break
//            }
//        }
        
//        setActivityIndicator(true)
//
//        _ = downloadImageRx(url: IMAGE_URL)
//        .subscribe { event in
//            switch event {
//            case .next(let image):
//                DispatchQueue.main.async {
//                    self.imageView.image = image
//                    self.setActivityIndicator(false)
//
//                    let hostingController = UIHostingController(rootView: SwiftUIView())
//                    self.present(hostingController, animated: true, completion: nil)
//                }
//            case .completed:
//                break
//            case .error:
//                break
//            }
//        }
//        .disposed(by: disposeBag)
        
//        setActivityIndicator(true)
//
//        downloadImageRx(url: IMAGE_URL)
//            .debug()
//            .map { $0 }
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { [weak self] image in
//                self?.imageView.image = image
//                self?.setActivityIndicator(false)
//            })
//            .disposed(by: disposeBag)
        
        
    }
    
    
    
}

