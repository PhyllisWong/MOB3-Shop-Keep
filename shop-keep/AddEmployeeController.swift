//
//  AddEmployeeController.swift
//  shop-keep
//
//  Created by Phyllis Wong on 2/13/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import UIKit
import CoreData.NSFetchedResultsController

class AddEmployeeController: UIViewController {
    
    // Outlets
    @IBOutlet weak var employeeNameTextField: UITextField!
    @IBOutlet weak var managerSegmentControl: UISegmentedControl!
    @IBOutlet weak var managerPicker: UIPickerView!
    

    
    // Variables
    let stack = CoreDataStack.instance
    lazy var employee = Employee(
        context: stack.privateContext
    )
    
    var shop: Shop!
    var managers = [String]()
    
    func fetchEmployees() {
        var employees: [Employee]?
        let stack = CoreDataStack.instance
        let fetchRequest: NSFetchRequest<Employee> = NSFetchRequest(entityName: "Employee")
        

        
        fetchRequest.predicate = NSPredicate(format: "shop == %@", (self.shop)!)
    
        do {
            employees = try stack.viewContext.fetch(fetchRequest)
            
            for emp in employees! {
                if emp.isManager == true {
                    guard let name = emp.name else {
                        return
                    }
                    self.managers.append(name)
                    print("name: \(name)")
                    print("is manager: \(emp.isManager)\n")
                }
            }
            // print(self.managers)
//            return employees
        } catch {
            print("BAD")
            assert(false, error.localizedDescription)
        }
        print(self.managers)
        
    }
    
    // Get the names of all managers in a shop and display them in a UIPicker

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allEmployees = self.shop.employees?.allObjects as! [Employee]
        fetchEmployees()
    }

    // Use picker to sssign manager to eomplyee
    @IBAction func pressedSave(_ sender: UIBarButtonItem) {
        guard let name = employeeNameTextField.text else {
            return
        }
        
        employee.name = name

        self.shop.addToEmployees(employee)
        stack.saveTo(context: stack.privateContext)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didChangeManager(_ sender: Any) {
        if managerSegmentControl.selectedSegmentIndex == 0 {
            // pressed no (not a manager)
            employee.isManager = false
        } else {
            // pressed yes (is a manager, picker should hide)
            employee.isManager = true
        }
    }
}

//extension AddEmployeeController: UIPickerViewDelegate, UIPickerViewDataSource {
//
//}


