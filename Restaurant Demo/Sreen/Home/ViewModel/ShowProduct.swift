//
//  ShowProduct.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/13/21.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire
class ShowProductViewModel {
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    private var branchesModelSubject = PublishSubject<[ProductModelDatumExtra]>()
    var branchesModelObservable: Observable<[ProductModelDatumExtra]> {
        return branchesModelSubject
    }
    var isTableHiddenObservable: Observable<Bool> {
        return isTableHidden.asObservable()
    }
    func ShowProduct(categoryId:Int?) {
        loadingBehavior.accept(true)
        NetWorkManager.sendRequest(method: .post, url: category,parameters:["categoryId":categoryId ?? 0]) { [weak self](err, response:ProductModel?) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = err {
            }  else {
                guard let branchesModel = response else { return }
                if branchesModel.data?.products?.count ?? 0 > 0 {
                    self.branchesModelSubject.onNext(branchesModel.data?.products ?? [])
                    self.isTableHidden.accept(false)
                } else {
                    self.isTableHidden.accept(true)
                }
            }
        }
    }
}
