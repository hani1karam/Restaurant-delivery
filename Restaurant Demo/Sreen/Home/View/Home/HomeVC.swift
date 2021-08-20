//
//  HomeVC.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/13/21.
//
import UIKit
import RxSwift
import RxCocoa
import SideMenu
class HomeVC: UIViewController,UICollectionViewDelegate {
    
    @IBOutlet weak var HomeCV: UICollectionView!
    @IBOutlet weak var ProductCV: UICollectionView!
    
    let branchesViewModel = BranchesViewModel()
    let HomebranchesViewModel = ShowProductViewModel()
    let disposeBag = DisposeBag()
    let homeCollectionView = "HomeCollectionView"
    var indexSelected = 0
    var branchesModel = [Datum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpBinding()
        getBranches()
        self.HomebranchesViewModel.ShowProduct(categoryId: 1)
        ProductCV.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func setUpUI() {
        setUpLoading()
        setUpUTableViewDataSource()
        setUpUTableViewDelegate()
        HomesetUpLoading()
        HomeUTableViewDelegate()
        HomesetUpUTableViewDataSource()
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
    
    func setUpUTableViewDataSource() {
        self.branchesViewModel.branchesModelSubject.asObservable()
            .bind(to: self.HomeCV
                    .rx
                    .items(cellIdentifier: homeCollectionView,
                           cellType: HomeCollectionView.self)) { row, branch, cell in
                cell.titleLBL.text =  self.branchesModel[row].name
                if self.indexSelected  == row {
                    cell.footer.isHidden = false
                    cell.titleLBL.font = UIFont(name: "Cairo-SemiBold", size: 19)
                    cell.titleLBL.textColor = #colorLiteral(red: 0.9603744149, green: 0.5553367138, blue: 0, alpha: 1)
                }else{
                    cell.footer.isHidden = true
                    cell.titleLBL.font = UIFont(name: "Cairo-Light", size: 19)
                    cell.titleLBL.textColor = #colorLiteral(red: 0.3294117647, green: 0.3647058824, blue: 0.3529411765, alpha: 1)
                }
            }.disposed(by:disposeBag)
        
    }
    
    func setUpUTableViewDelegate() {
        HomeCV.rx.itemSelected
            .subscribe (onNext:{ [weak self] indexPath in
                self?.HomebranchesViewModel.ShowProduct(categoryId: self?.branchesModel[indexPath.row].id)
                self?.indexSelected = indexPath.row
                self?.HomeCV.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    func getBranches() {
        branchesViewModel.ShowProduct()
    }
    
    func HomesetUpLoading() {
        HomebranchesViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoader()
                
            } else {
                self.hideLoader()
            }
        }).disposed(by: disposeBag)
    }
    
    func HomesetUpUTableViewDataSource() {
        self.HomebranchesViewModel.branchesModelObservable
            .bind(to: self.ProductCV
                    .rx
                    .items(cellIdentifier: "productCell",
                           cellType: productCell.self)) { row, branch, cell in
                cell.titleLBL.text = branch.name
                cell.reloadImage(image: branch)
                cell.PriceProduct.text = "\(branch.discount ?? "") EGP"
            }.disposed(by:disposeBag)
    }
    
    @IBAction func Menu(_ sender: Any) {
        if let menu = UIStoryboard(name: "Menu", bundle: nil)
            .instantiateViewController(withIdentifier: "Side") as? SideMenuNavigationController {
            menu.statusBarEndAlpha = 0
            menu.alwaysAnimate = true
            menu.blurEffectStyle = .none
            menu.presentationStyle = .viewSlideOutMenuIn
            menu.presentationStyle.menuOnTop = true
            menu.presentationStyle.presentingEndAlpha = 0.25
            menu.presentationStyle.onTopShadowOpacity = 1
            menu.presentationStyle.onTopShadowRadius = 0
            menu.presentationStyle.onTopShadowColor = .black
            menu.setNavigationBarHidden(true, animated: false)
            present(menu, animated: true, completion: nil)
        }
    }
    
    func HomeUTableViewDelegate() {
        ProductCV
            .rx
            .modelSelected(ProductModelDatumExtra.self)
            .subscribe(onNext: { [weak self]  branch in
                let Deatils = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
                Deatils.name = branch.name
                Deatils.image2 = branch.image
                Deatils.price2 = Double((branch.size?[0].price)!)
                Deatils.id = branch.id
                Deatils.desrbtion = branch.productDescription
                Deatils.discount = branch.discount
                Deatils.SizeFood = branch.size!
                Deatils.ExtraFood = branch.extra!
                Deatils.count = branch.size?.count
                Deatils.count1 = branch.extra?.count
                self?.navigationController?.pushViewController(Deatils, animated: true)
            })
            .disposed(by: disposeBag)
        
    }
    @IBAction func cartBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "CartVC")
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
}
