//
//  AddToCartViewModel.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/15/21.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire
class AddToCartViewModel {
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    private var branchesModelSubject = PublishSubject<[AddCartModel]>()
    var branchesModelObservable: Observable<[AddCartModel]> {
        return branchesModelSubject
    }
    private var loginModelSubject = PublishSubject<AddCartModel>()
    var loginModelObservable: Observable<AddCartModel> {
        return loginModelSubject
    }
    func addToCart(productid:Int?,id:Int?,quantity:String?,sizeid:Int?,extraid:Int?) {
        loadingBehavior.accept(true)
        let params = ["productId":productid ?? 0,
                      "userId": id ?? 0,
                      "quantity":quantity ?? "",
                      "sizeId":sizeid ?? 0 ,
                      "extraId":extraid ?? 0] as [String : Any]
        
        NetWorkManager.sendRequest(method: .post, url: addCart,parameters:params) {[weak self] (err, response:AddCartModel?) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = err {
                // network error
            }
            else {
                guard let loginModel = response else { return }
                self.loginModelSubject.onNext(loginModel)
            }
        }
    }
}
