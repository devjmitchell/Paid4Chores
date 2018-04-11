//
//  ViewController.swift
//  Paid4Chores
//
//  Created by Jason Mitchell on 4/11/18.
//  Copyright © 2018 Jason Mitchell. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addChildTapped(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Child", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newChild = Child()
            newChild.name = textField.text!
            newChild.payment = 0.0
            
            do {
                try self.realm.write {
                    self.realm.add(newChild)
                }
            } catch {
                print("Error saving: \(error)")
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Jimmy"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

