//
//  CartVC.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/16/21.
//

import UIKit
import RxSwift
import RxCocoa

class CartVC: UIViewController {
    
    @IBOutlet weak var CartTV: UITableView!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var nodatafound: UILabel!
    
    let branchesViewModel = CartViewModel()
    let disposeBag = DisposeBag()
    var branchesModel = [Item]()
    var index:Int?
    var sizeid:Int?
    var exteraid:Int?
    var productid:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpLoading()
        setUpBinding()
        setUpUTableViewDataSource()
        setUpUTableViewDelegate()
        getBranches()
        loadUserData()
        nodatafound.isHidden = true
    }
    
    
    func setUpLoading() {
        branchesViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoader()
                
            } else {
                self.hideLoader()
            }
        }).disposed(by: disposeBag)
    }
    
    func setUpBinding() {
        self.branchesViewModel.branchesModelSubject.subscribe { (model) in
            self.branchesModel = model
        }.disposed(by: disposeBag)
    }
    func loadUserData() {
        
        let id2:Int = UserDefaults.standard.value(forKey: "IDUSER") as! Int
        let params = ["userId":id2 ]
        NetWorkManager.sendRequest(method: .post, url: userCart,parameters:params) { [weak self](err, response:ShowCartModel?) in
            guard let self = self else {return}
            if response?.status == true {
                self.total.text = "\(response?.data?.totalPrice! ?? "")"
            }
        }
    }
    func setUpUTableViewDataSource() {
        
        self.branchesViewModel.branchesModelSubject.asObservable()
            .bind(to: self.CartTV
                    .rx
                    .items(cellIdentifier: "CartTableViewCell",
                           cellType: CartTableViewCell.self)) { row, branch, cell in
                cell.lbl.text = self.branchesModel[row].productName
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string:"\(self.branchesModel[row].price ?? "")EGP")
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                cell.priceCart.attributedText = attributeString
                cell.priceoffer.text = "\(self.branchesModel[row].discountPrice ?? "")" + " " + "EGP"
                cell.configure(compines: self.branchesModel[row])
                cell.Delet.tag = row
                cell.Delet.addTarget(self, action: #selector(self.subscribeTapped(_:)), for: .touchUpInside)
                self.sizeid =  self.branchesModel[self.index ?? 0].sizeID
                self.exteraid =  self.branchesModel[self.index ?? 0].extraID
                self.productid =  self.branchesModel[self.index ?? 0].productID
                
                
            }.disposed(by:disposeBag)
        
    }
    
    func setUpUTableViewDelegate() {
        CartTV.rx.itemSelected
            .subscribe (onNext:{ [weak self] indexPath in
            })
            .disposed(by: disposeBag)
    }
    
    func getBranches() {
        let idUser:Int = UserDefaults.standard.value(forKey: "IDUSER") as! Int
        
        branchesViewModel.ShowProduct(userId: idUser)
    }
    @objc
    func subscribeTapped(_ sender: UIButton){
        index = sender.tag
        let id2:Int = UserDefaults.standard.value(forKey: "IDUSER") as! Int
        let param = ["productId": productid!
                     ,"userId": id2,
                     "sizeId":sizeid!
                     ,"extraId":exteraid!] as [String : Any]
        NetWorkManager.sendRequest(method: .post, url: removeFromCart,parameters:param) {[weak self] (err, response:DeletCartModel?) in
            if response?.status == true{
                self?.deleteProduct(at: sender.tag, { [weak self]  in
                    guard let strongSelf = self else {return}
                    strongSelf.CartTV.reloadData()
                })
                ToastManager.shared.showError(message: "تم الحذف بنجاح", view: (self?.view)!, backgroundColor: .black)
                self?.CartTV.reloadData()
                
            }
        }
        
    }
    func deleteProduct(at item: Int, _ completion: () -> Void) {
        self.branchesModel.remove(at: item)
        completion()
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        
    }
    @IBAction func SumbitOrder(_ sender: Any) {
        
        if let popupvc = storyboard?.instantiateViewController(withIdentifier:"ConfirmOrderVC") as? ConfirmOrderVC {
            self.present(popupvc,animated: true,completion: nil)
        }
    }
}
