//
//  OrderVC.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/17/21.
//

import UIKit

class OrderVC: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var OrderTV: UITableView!
    var items = [ShowOrderModelDatum]()
    var id: Int?
    var index = 0
    var viewhome:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.OrderTV.separatorStyle = .none
        OrderTV.delegate = self
        OrderTV.dataSource = self
        ShowOrder()
    }
    
    func ShowOrder(){
        let id2:Int = UserDefaults.standard.value(forKey: "IDUSER") as! Int
        let param = ["userId":id2]
        self.showLoader()
        NetWorkManager.sendRequest(method: .post, url: showorder,parameters:param) {[weak self] (err, response:ShowOrderModel?) in
            self?.hideLoader()
            guard let self = self else {return}
            if response?.status == true {
                guard  let data = response?.data else {return}
                self.items = data
                self.OrderTV.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowOrderTableViewCell", for: indexPath) as! ShowOrderTableViewCell
        cell.day_title.text = items[indexPath.row].dayTitle
        cell.date.text = items[indexPath.row].date
        cell.hour.text = items[indexPath.row].hour
        cell.format.text = items[indexPath.row].format
        viewhome = cell.HomeView
        if items[indexPath.row].status == "New"{
            cell.status.text  = "جديد"
            cell.HomeView.layer.borderWidth = 1.0
            cell.HomeView.layer.borderColor = #colorLiteral(red: 1, green: 0.5345413089, blue: 0, alpha: 1)
            
            
        }
        else if items[indexPath.row].status == "Cooking"{
            cell.status.text = "بيتحضر"
            cell.HomeView.layer.borderWidth = 1.0
            cell.HomeView.layer.borderColor = #colorLiteral(red: 1, green: 0.5345413089, blue: 0, alpha: 1)
            
            
        }
        else if items[indexPath.row].status == "Delivered" {
            cell.status.text = "وصل"
            cell.HomeView.layer.borderWidth = 1.0
            cell.HomeView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
        }
        else {
            cell.status.text = "ف الطريق"
            cell.HomeView.layer.borderWidth = 1.0
            cell.HomeView.layer.borderColor = #colorLiteral(red: 1, green: 0.5345413089, blue: 0, alpha: 1)
            
        }
        cell.total.text = "\(items[indexPath.row].total)" + " " + "EP"
        if items[indexPath.row].status == "New"{
            cell.status1.image = UIImage(named:"Full")
            cell.status2.image = UIImage(named:"Empty")
            cell.status3.image = UIImage(named:"Empty")
            cell.status4.image = UIImage(named:"Empty")
        }
        else if items[indexPath.row].status == "Cooking" {
            cell.status1.image = UIImage(named:"Full")
            cell.status2.image = UIImage(named:"Full")
            cell.status3.image = UIImage(named:"Empty")
            cell.status4.image = UIImage(named:"Empty")
        }
        else if items[indexPath.row].status == "Delivered" {
            cell.status1.image = UIImage(named:"Full")
            cell.status2.image = UIImage(named:"Full")
            cell.status3.image = UIImage(named:"Full")
            cell.status4.image = UIImage(named:"Full")
        }
        else {
            cell.status1.image = UIImage(named:"Full")
            cell.status2.image = UIImage(named:"Full")
            cell.status3.image = UIImage(named:"Full")
            cell.status4.image = UIImage(named:"Empty")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 182
    }
    
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        let Deatils = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "OrderDetailsVC") as! OrderDetailsVC
        Deatils.id = items[indexPath.row].id
        Deatils.status = items[indexPath.row].status
        Deatils.hour = items[indexPath.row].hour
        Deatils.date = items[indexPath.row].date
        Deatils.price = "\(items[indexPath.row].total)"
        Deatils.format = items[indexPath.row].format
        Deatils.total  = "\(items[indexPath.row].total)"
        Deatils.address = items[indexPath.row].address
        Deatils.phone2 = items[indexPath.row].phone
        Deatils.subTotal = items[indexPath.row].subTotal
        self.navigationController?.pushViewController(Deatils, animated: true)
        
    }
}
