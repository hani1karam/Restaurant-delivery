//
//  ConfirmOrderVC.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/17/21.
//

import UIKit

class ConfirmOrderVC: UIViewController {
    @IBOutlet weak var ShapeView: UIView!
    @IBOutlet weak var AddressTxt: UITextField!
    @IBOutlet weak var PhoneTxt: UITextField!
    @IBOutlet weak var Note: UITextField!
    
    var Phone:String?
    var Address:String?
    var id2:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ShapeView.layer.cornerRadius = 10
        ShapeView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapRecognizer)
        tapRecognizer.delegate = self
        getdata()
        
    }
    func getdata(){
        Phone = UserDefaults.standard.value(forKey: "NAMEPHONE") as? String
        Address = UserDefaults.standard.value(forKey: "NAMEADRESS") as? String
        id2 = UserDefaults.standard.value(forKey: "IDUSER") as? Int
        AddressTxt.text = Address
        PhoneTxt.text = Phone
        
    }
    @objc func tapped(gestureRecognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func ConfirmOrderBtn(_ sender: Any) {
        let id = ["userId":id2 ?? -1
                  ,"address":AddressTxt.text!,
                  "phone":PhoneTxt.text!,
                  "note":Note.text!] as [String : Any]
        self.showLoader()
        NetWorkManager.sendRequest(method: .post, url: submitOrder,parameters:id) {[weak self] (err, response:SumbitOrder?) in
            guard let self = self else {return}
            self.hideLoader()
            if response?.status == true {
                ToastManager.shared.showError(message: (response?.data?.message)!, view: self.view, backgroundColor: .black)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
}
