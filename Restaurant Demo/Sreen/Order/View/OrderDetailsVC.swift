//
//  ConfirmOrderVC.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/17/21.
//

import UIKit

class OrderDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var HomeView: CustomeView!
    @IBOutlet weak var HomeView3: CustomeView!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var OrderTV: UITableView!
    @IBOutlet weak var Back: UIButton!
    @IBOutlet weak var Total: UILabel!
    @IBOutlet weak var Tas: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var delivery: UILabel!
    var id: Int?
    var index = 0
    var status: String?
    var day: String?
    var date: String?
    var hour: String?
    var price: String?
    var format:String?
    var total: String?
    var phone2: String?
    var address: String?
    var viewhome:UIView?
    var subTotal: String?
    var items = [ShowDetilaModelProduct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if status == "New" {
            self.Status.text = "جديد"
            img.image = UIImage(named:"First")
            
        }
        else if status == "Cooking" {
            self.Status.text = "بيتحضر"
            img.image = UIImage(named:"two")
            
        }
        else if status == "Delivered"{
            self.Status.text = "وصل"
            img.image = UIImage(named:"full-1")
            
        }
        else {
            self.Status.text = "ف الطريق"
            img.image = UIImage(named:"three")
        }
        Total.text = "الاجمالي:" + " " + (total)! + " " + "(جنيه)"
        delivery.text = "رسوم التوصيل:"  + " " +  "0"
        Tas.text = total
        phone.text = phone2
        Address.text = address
        
        HomeView.backgroundColor = UIColor.white
        HomeView.backgroundColor = UIColor.white
        HomeView.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.5))
        HomeView.layer.cornerRadius = 35.0
        //////////////////
        HomeView3.backgroundColor = UIColor.white
        HomeView3.backgroundColor = UIColor.white
        HomeView3.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.5))
        HomeView3.layer.cornerRadius = 35.0
        /////////////////////////////
        ShowDetails()
        OrderTV.delegate = self
        OrderTV.dataSource = self
        ///////////////
        Back.layer.cornerRadius = 15

    }
    func ShowDetails(){
        self.showLoader()
        let param = ["orderId":id]
        NetWorkManager.sendRequest(method: .post, url: userOrder,parameters:param as [String : Any]) {[weak self] (err, response:ShowDetilaModel?) in
            guard let self = self else {return}
            self.hideLoader()
            self.items = response?.data?.products ?? []
            self.OrderTV.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DetailsTableViewCell
        cell.nameFood.text = items[indexPath.row].productName
        cell.price.text = "\(items[indexPath.row].price)" + " " + "EGP"
        cell.size.text = items[indexPath.row].sizeName
        cell.extra.text = items[indexPath.row].extraName
        cell.Number.text = "العدد:" + " " + "\(items[indexPath.row].quantity)"
        cell.Total.text = items[indexPath.row].total
        cell.configure(compines: items[indexPath.row])
        cell.size.text = items[indexPath.row].sizeName
        return cell
    }
    
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        
    }
    
}
