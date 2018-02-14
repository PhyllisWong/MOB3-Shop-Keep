//
//  EmployeeViewController.swift
//  shop-keep
//
//  Created by Eliel A. Gordon on 2/11/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import UIKit

class EmployeeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var shop: Shop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var leftBarItem: Array = { () -> [UIBarButtonItem] in
//            let btnBack = UIButton(type: .custom)
//            btnBack.frame = kBAR_FRAME
//            btnBack.addTarget(self, action: #selector(clickOnBackBtn(_:)), for: .touchUpInside)
//            let item = UIBarButtonItem(customView: btnBack)
//            item.tag = 3
//            return [item]
//        }()
        
        let nav = UINavigationController(rootViewController: ShopsViewController())
//        self.navigationItem.rightBarButtonItem = item1
        //self.navigationController?.pushViewController(self, animated: true)
        nav.navigationItem.largeTitleDisplayMode = .never
        tableView.dataSource = self
    }
}

extension EmployeeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return shop?.employees?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath)
        
        guard let employees = shop?.employees?.allObjects as? [Employee]
            else {return cell}
        let employee = employees[indexPath.row]
        
        cell.textLabel?.text = employee.name
        
        // ternary operator, if the boolean is true, will take the left side, if false will take the right side
        cell.detailTextLabel?.text = employee.isManager ? "Manager" : "Managed by: \(employee.manager?.name ?? "")"
        
        return cell
    }
}
