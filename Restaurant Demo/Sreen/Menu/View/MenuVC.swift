//
//  MenuVC.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/14/21.
//

import UIKit
import SideMenu

class MenuVC: UIViewController,SideMenuNavigationControllerDelegate {
    @IBOutlet weak var MenuTV: UITableView!
    var item = [MenuModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MenuTV.delegate = self
        MenuTV.dataSource = self
        let nib = UINib(nibName: "MenuTableViewCell", bundle: nil)
        MenuTV.register(nib, forCellReuseIdentifier: "MenuTableViewCell")
        self.MenuTV.separatorStyle = .none
        item.append(MenuModel(image: "menu", title: "Restaurant Menu"))
        item.append(MenuModel(image: "order", title: "My order"))
        item.append(MenuModel(image: "logout", title: "Logout"))
    }
}
extension MenuVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as!
            MenuTableViewCell
        cell.name.text = item[indexPath.row].title
        cell.img.image = UIImage(named:item[indexPath.row].image ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = MenuTV.cellForRow(at: indexPath) as! MenuTableViewCell
        cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 0.5745639205, blue: 0, alpha: 1)
        switch indexPath.row {
        case 0:
            let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
                as! HomeVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "OrderVC")
                as! OrderVC
            self.navigationController?.pushViewController(vc, animated: true)

        default:
            UserDefaults.standard.removeObject(forKey: "IDUSER")
            UserDefaults.standard.synchronize()
            if #available(iOS 13.0, *) {
                let vc = UIStoryboard(name:"Login", bundle: nil).instantiateViewController(identifier: "LoginVC")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
                
            } else {
                let vc = UIStoryboard(name:"Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }

        }
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = MenuTV.cellForRow(at: indexPath) as! MenuTableViewCell
        cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}


