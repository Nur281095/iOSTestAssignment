//
//  LoginTableView.swift
//  iOSTestAssignment
//
//  Created by Naveed ur Rehman on 25/06/2022.
//

import UIKit

class LoginTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var loginItems = [SearchAPI]()
    
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    func reloadTbl(){
        self.delegate = self
        self.dataSource = self
        self.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loginItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoginCell") as! LoginCell
        cell.configCell(model: loginItems[indexPath.row])
        return cell
    }
}
