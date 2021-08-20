//
//  DetailsVC.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/13/21.
//

import UIKit
import RxCocoa
import RxSwift

class DetailsVC: UIViewController {
    @IBOutlet weak var DetailsView: CustomeView!
    @IBOutlet weak var ExtraView: CustomeView!
    @IBOutlet weak var QunatityView: CustomeView!
    @IBOutlet weak var LablView: UIView!
    @IBOutlet weak var namefood: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var CounterCart: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var Back: UIButton!
    @IBOutlet weak var Cart: UIButton!
    @IBOutlet weak var CartBtn: CustomeView!
    @IBOutlet weak var Desrbtion: UILabel!
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var SizeTV: UITableView!
    @IBOutlet weak var ExtraTV: UITableView!
    @IBOutlet weak var ExtaView: CustomeView!
    @IBOutlet weak var Size: UILabel!
    @IBOutlet weak var Extra: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addToCart: UIButton!
    
    var name: String?
    var image2: String?
    var price2: Double?
    var id:Int?
    var desrbtion:String?
    var discount:String?
    var SizeFood:[ProductModelDatumExtraExtra] = []
    var ExtraFood:[ProductModelDatumExtraExtra] = []
    var count: Int?
    var count1:Int? 
    var sizeid:Int?
    var extraid:Int?
    var index:Int?
    var pricesize:Int?
    var priceexra:Int?
    let loginViewModel = AddToCartViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailsView.backgroundColor = UIColor.white
        DetailsView.backgroundColor = UIColor.white
        DetailsView.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.5))
        ExtraView.backgroundColor = UIColor.white
        ExtraView.backgroundColor = UIColor.white
        ExtraView.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.5))
        
        ExtaView.backgroundColor = UIColor.white
        ExtaView.backgroundColor = UIColor.white
        ExtaView.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.5))
        
        QunatityView.backgroundColor = UIColor.white
        QunatityView.backgroundColor = UIColor.white
        QunatityView.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.5))
        LablView.layer.cornerRadius = 15
        Back.layer.cornerRadius = 15
        Cart.layer.cornerRadius = 15
        CartBtn.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.5))
        BackView.layer.cornerRadius = 15
        SizeTV.delegate = self
        SizeTV.dataSource = self
        ExtraTV.dataSource = self
        ExtraTV.delegate = self
        ExtraTV.dataSource = self
        ExtraTV.delegate = self
        
        
        self.namefood.text = name ?? ""
        self.image.kf.setImage(with: URL(string:image2 ?? ""))
        self.price.text = "\(price2 ?? 0)" + " " + "EGP"
        self.Desrbtion.text = desrbtion
        scrollView.alwaysBounceVertical = true
        subscribeToLoading()
        subscribeToResponse()
        subscribeToLoginButton()
    }
    
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func Add(_ sender: Any) {
        guard var counter = Int(self.CounterCart.text!) else {return}
        counter += 1
        self.CounterCart.text = "\(counter)"
        CounterCart.text = self.CounterCart.text
    }
    
    @IBAction func Decrease(_ sender: Any) {
        guard var counter = Int(self.CounterCart.text!) else {return}
        
        if counter <= 1 {
            ToastManager.shared.showError(message: "لا يجب اتقل عن واحد", view: self.view, backgroundColor: .red)
            
        }
        
        else {
            counter -= 1
            self.CounterCart.text = "\(counter)"
            CounterCart.text = self.CounterCart.text
        }
    }
    
    func validData() -> Bool{
        if sizeid == nil  && extraid == nil{
            ToastManager.shared.showError(message: "عليك اختيار الحجم والاضافات", view: self.view, backgroundColor: .red)
            
            return false
        }
        else if sizeid == nil {
            ToastManager.shared.showError(message: "عليك اختيار الحجم", view: self.view, backgroundColor: .red)
            
            return false
        }
        else if extraid == nil {
            ToastManager.shared.showError(message: "عليك اختيار الاضافات", view: self.view, backgroundColor: .red)
            
            return false
        }
        return true
    }
    @IBAction func addToCart(_ sender: Any) {
        
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
                ToastManager.shared.showError(message: $0.data ?? "", view: self.view, backgroundColor: .black)
            }
            else {
                ToastManager.shared.showError(message: $0.data ?? "", view: self.view, backgroundColor: .black)
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToLoginButton() {
        addToCart.rx.tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self](_) in
                guard let self = self else { return }
                let idUser:Int = UserDefaults.standard.value(forKey: "IDUSER") as! Int
                
                self.loginViewModel.addToCart(productid:self.id,
                                              id:idUser,quantity:self.CounterCart.text!
                                              ,sizeid:self.sizeid ?? 0,
                                              extraid:self.extraid ?? 0)
            }).disposed(by: disposeBag)
    }
    
    @IBAction func cartBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "CartVC")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
