//
//  AddEmployeeController.swift
//  shop-keep
//
//  Created by Phyllis Wong on 2/13/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import UIKit

class AddEmployeeController: UIViewController {
    
    // Outlets
    @IBOutlet weak var employeeNameTextField: UITextField!
    @IBOutlet weak var managedByTextField: UITextField!
    @IBOutlet weak var managerSegmentControl: UISegmentedControl!

    // Variables
    let stack = CoreDataStack.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func pressedSave(_ sender: UIBarButtonItem) {
        guard let name = employeeNameTextField.text, let isManager =  managerSegmentControl else {
            return
        }
        
        let employee = Employee(
            context: stack.privateContext
        )
        
        employee.name = name
        employee.isManager = isManager
        
        print("\nshop.name: \(String(describing: employee.name))\n")
        
        stack.saveTo(context: stack.privateContext)
        self.navigationController?.popViewController(animated: true)
    }
    }
    
}
