//
//  AddShopController.swift
//  shop-keep
//
//  Created by Phyllis Wong on 2/13/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import UIKit

class AddShopController: UIViewController {
    
    // Outlets
    @IBOutlet weak var shopNameTextField: UITextField!
    
    
    // Variables
    let coreDataStack = CoreDataStack.instance

    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // Actions
    @IBAction func didPressSave(_ sender: Any) {
        
        guard let name = shopNameTextField.text else {
            return
        }
        
        let shop = Shop(
            context: coreDataStack.privateContext
        )
        
        shop.name = name
        
        print("\nshop.name: \(String(describing: shop.name))\n")
        
        coreDataStack.saveTo(context: coreDataStack.privateContext)
        self.navigationController?.popViewController(animated: true)
    }
    
}
