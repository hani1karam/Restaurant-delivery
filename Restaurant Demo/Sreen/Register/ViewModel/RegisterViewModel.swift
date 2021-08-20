//
//  RegisterViewModel.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/13/21.
//

import Foundation
import RxCocoa
import RxSwift
class RegisterViewModel {
    var NameBehavior = BehaviorRelay<String>(value: "")
    var EmailBehavior = BehaviorRelay<String>(value: "")
    var PhoneBehavior = BehaviorRelay<String>(value: "")
    var PasswordBehavior = BehaviorRelay<String>(value: "")
    var confirm_password = BehaviorRelay<String>(value: "")
    var address = BehaviorRelay<String>(value: "")
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var loginModelSubject = PublishSubject<RegisterModel>()
    var loginModelObservable: Observable<RegisterModel> {
        return loginModelSubject
    }
    
    func registerClicked() {
        loadingBehavior.accept(true)
        let params = ["name":NameBehavior.value,
                      "email":EmailBehavior.value,
                      "phone":PhoneBehavior.value,
                      "password":PasswordBehavior.value,
                      "confirm_password":confirm_password.value,
                      "address":address.value]
        NetWorkManager.sendRequest(method: .post, url: Register,parameters:params) {[weak self] (err, response:RegisterModel?) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            self.loadingBehavior.accept(false)
            if let error = err {
                // network error
            }
            else {
                guard let loginModel = response else { return }
                self.loginModelSubject.onNext(loginModel)
                UserDefaults.standard.set(response?.data?.id, forKey: "IDUSER")
                UserDefaults.standard.set(response?.data?.name, forKey: "NAMEUSER")
                UserDefaults.standard.set(response?.data?.phone, forKey: "NAMEPHONE")
                UserDefaults.standard.set(response?.data?.email, forKey: "NAMEEMAIL")
                UserDefaults.standard.set(response?.data?.address, forKey: "NAMEADRESS")
                UserDefaults.standard.synchronize()
                
            }
        }
    }
}
