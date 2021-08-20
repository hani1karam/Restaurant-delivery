//
//  RegisterVC.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/13/21.
//

import UIKit
import RxCocoa
import RxSwift

class RegisterVC: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var PasswordTxt: UITextField!
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    let loginViewModel = RegisterViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PasswordTxt.rightViewMode = .unlessEditing
        button.setImage(UIImage(named: "Group 1003"), for: .normal)
        bindTextFieldsToViewModel()
        subscribeToLoading()
        subscribeToResponse()
        subscribeToLoginButton()
        
    }
    
    
    @IBAction func btnPasswordVisiblityClicked(_ sender: Any) {
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
        if (sender as! UIButton).isSelected {
            self.PasswordTxt.isSecureTextEntry = false
            button.setImage(UIImage(named: "Path 50"), for: .normal)
        } else {
            self.PasswordTxt.isSecureTextEntry = true
            button.setImage(UIImage(named: "Group 1003"), for: .normal)
        }
    }
    func bindTextFieldsToViewModel() {
        EmailTxt.rx.text.orEmpty.bind(to: loginViewModel.EmailBehavior).disposed(by: disposeBag)
        PasswordTxt.rx.text.orEmpty.bind(to: loginViewModel.PasswordBehavior).disposed(by: disposeBag)
    }
    func subscribeToLoading() {
        loginViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoader()
                
            } else {
                self.hideLoader()
                
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToResponse() {
        loginViewModel.loginModelObservable.subscribe(onNext: {
            if $0.status == true {
                ToastManager.shared.showError(message: "SUCCESS", view: self.view, backgroundColor: .black)
                let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else {
                ToastManager.shared.showError(message: "Error", view: self.view, backgroundColor: .red)
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToLoginButton() {
        loginButton.rx.tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self](_) in
                guard let self = self else { return }
                self.loginViewModel.registerClicked()
            }).disposed(by: disposeBag)
    }
    
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
}
