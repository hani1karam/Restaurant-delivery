//
//  CartViewModel.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/16/21.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire
class CartViewModel {
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    var branchesModelSubject = PublishSubject<[Item]>()
    var isTableHiddenObservable: Observable<Bool> {
        return isTableHidden.asObservable()
    }
    func ShowProduct(userId:Int?) {
        loadingBehavior.accept(true)
        let params = ["userId":userId ?? 0]
        NetWorkManager.sendRequest(method: .post, url: userCart,parameters:params) { [weak self](err, response:ShowCartModel?) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = err {
            }  else {
                guard let branchesModel = response else { return }
                if branchesModel.data?.items?.count ?? 0 > 0 {
                    self.branchesModelSubject.onNext(branchesModel.data?.items ?? [])
                    self.isTableHidden.accept(false)
                } else {
                    self.isTableHidden.accept(true)
                }
            }
        }
    }
}
