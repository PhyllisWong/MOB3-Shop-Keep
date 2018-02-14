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
    @IBOutlet weak var managedByTextField: UITextField!
    @IBOutlet weak var managerSegmentControl: UISegmentedControl!
    @IBOutlet weak var managerPicker: UIPickerView!
    

    
    // Variables
    let stack = CoreDataStack.instance
    lazy var employee = Employee(
        context: stack.privateContext
    )
    var shop: String?
    var managers = [String]()
    
    func fetchEmployees() {
        var employees: [Employee]?
        let stack = CoreDataStack.instance
        let fetchRequest: NSFetchRequest<Employee> = NSFetchRequest(entityName: "Employee")
        
        do {
            employees = try stack.privateContext.fetch(fetchRequest)
            
            for emp in employees! {
                guard let name = emp.name else {
                    return
                }
                self.managers.append(name)
                print("name: \(name)")
                print("is manager: \(emp.isManager)\n")
            }
            
//            return employees
        } catch {
            assert(false, error.localizedDescription)
        }
    }
    
    // Get the names of all managers in a shop and display them in a UIPicker

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchEmployees()
        print("something???")
    }

    // Use picker to sssign manager to eomplyee
    @IBAction func pressedSave(_ sender: UIBarButtonItem) {
        guard let name = employeeNameTextField.text else {
            return
        }
        

        employee.name = name
        // employee.isManager = isManager
        
        print("\nshop.name: \(String(describing: employee.name))\n")
        
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


