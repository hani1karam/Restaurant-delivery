//
//  BranchesViewModel.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/13/21.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire
class BranchesViewModel {
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    var branchesModelSubject = PublishSubject<[Datum]>()
    var isTableHiddenObservable: Observable<Bool> {
        return isTableHidden.asObservable()
    }
    func ShowProduct() {
        loadingBehavior.accept(true)
        NetWorkManager.sendRequest(method: .post, url: allCategories) { [weak self](err, response:CatrogyModel?) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = err {
            }  else {
                guard let branchesModel = response else { return }
                if branchesModel.data?.count ?? 0 > 0 {
                    self.branchesModelSubject.onNext(branchesModel.data ?? [])
                    self.isTableHidden.accept(false)
                } else {
                    self.isTableHidden.accept(true)
                }
            }
        }
    }
}
