//
//  DetailsExtenstion.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/15/21.
//

import UIKit
extension DetailsVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == SizeTV{
            return count ?? 0
        }
        else {
            return count1 ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == SizeTV{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SizeTableViewCell", for: indexPath) as! SizeTableViewCell
            cell.pricee.text = SizeFood[indexPath.row].price
            cell.name.text = SizeFood[indexPath.row].name
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExtraTableViewCell", for: indexPath) as! ExtraTableViewCell
            cell.pricee.text = ExtraFood[indexPath.row].price
            cell.name.text = ExtraFood[indexPath.row].name
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == SizeTV {
            return 33
        }
        else {
            return 33
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        
        if tableView == SizeTV {
            sizeid = SizeFood[index!].id
            Size.text = SizeFood[index!].name
            let cell = SizeTV.cellForRow(at: indexPath) as! SizeTableViewCell
            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 0.5745639205, blue: 0, alpha: 1)
            pricesize = Int(SizeFood[index!].price ?? "")
        }
        else {
            extraid = ExtraFood[index!].id
            Extra.text = ExtraFood[index!].name
            let cell = ExtraTV.cellForRow(at: indexPath) as! ExtraTableViewCell
            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 0.5745639205, blue: 0, alpha: 1)
            priceexra = Int(ExtraFood[index!].price ?? "")
        }
        guard let Priceexra = priceexra else {return}
        guard let Pricesize = pricesize else {return}
        price.text = "\(Priceexra + Pricesize)"
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == SizeTV {
            let cell = SizeTV.cellForRow(at: indexPath) as! SizeTableViewCell
            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        else {
            let cell = ExtraTV.cellForRow(at: indexPath) as! ExtraTableViewCell
            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}
