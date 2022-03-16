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


class 나중에생기는데이터<T> {
    
    private let task:(@escaping(T) -> Void) -> Void
    
    init (task: @escaping(@escaping(T) -> Void) -> Void) {
        self.task = task
    }
    func 나중에오면(_ f: @escaping(T) -> Void) {
        task(f)
    }
}

class ViewController: UIViewController {

    
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    
    let IMAGE_URL = "https://picsum.photos/400/400/?random"
    
    private var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats:true) { [weak self] _ in
            self?.timeLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }

    func downloadImage(url: String, completion:@escaping(UIImage?) -> ()) {

        DispatchQueue.global().async {
            let url = URL(string: self.IMAGE_URL)!
            let data = try! Data(contentsOf: url)
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    func downloadImage(url: String) -> 나중에생기는데이터<UIImage?> {
        
        return 나중에생기는데이터() { f in
            DispatchQueue.global().async  {
                let url = URL(string: self.IMAGE_URL)!
                let data = try! Data(contentsOf: url)
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    f(image)
                }
            }
        }
    }
    
    func downloadImage(url: String) -> Observable<UIImage?> {
        
        return Observable.create() { f in
            DispatchQueue.global().async  {
                let url = URL(string: self.IMAGE_URL)!
                let data = try! Data(contentsOf: url)
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    f.onNext(image)
                    f.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    func downloadImageRx(url: String) -> Observable<UIImage?> {
        
        return Observable.create() { emmiter in
            let url = URL(string: self.IMAGE_URL)!
            
            let task = URLSession.shared.dataTask(with: url) {(data
                , _, err) in
                guard err == nil else {
                    emmiter.onError(err!)
                    return
                }
                
                let image = UIImage(data: data!)
                
                emmiter.onNext(image)
                emmiter.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create() {
                task.cancel()
            }
        }
    }
    
    
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
        setActivityIndicator(true)
        downloadImage(url: IMAGE_URL) { image in
            self.imageView.image = image
            self.activeIndicator.stopAnimating()
            let hostingController = UIHostingController(rootView: SwiftUIView())
            self.present(hostingController, animated: true, completion: nil)
        }
        
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
