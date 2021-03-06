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
    var employees: [Employee]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let nav = UINavigationController(rootViewController: ShopsViewController())
//        nav.navigationItem.largeTitleDisplayMode = .never
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        try? fetchedResultsController.performFetch()
        tableView.reloadData()
    }
    
    @IBAction func pressedAdd(_ sender: UIBarButtonItem) {
        // print("someStuff")
        self.performSegue(withIdentifier: "toAddEmployee", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toAddEmployee" {
                let addEmployeeVC = segue.destination as! AddEmployeeController
                addEmployeeVC.shop = self.shop
            }
        }
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
        
        guard let employees = self.shop?.employees?.allObjects as? [Employee]
            else {return cell}
        let employee = employees[indexPath.row]
        
        cell.textLabel?.text = employee.name
        
        // ternary operator, if the boolean is true, will take the left side, if false will take the right side
        cell.detailTextLabel?.text = employee.isManager ? "Manager" : "Managed by: \(employee.manager?.name ?? "")"
        
        return cell
    }
}




