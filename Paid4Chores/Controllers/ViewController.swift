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
        
        print("addChildTapped")
        
        let newChild = Child()
        newChild.name = "Jimmy"
        newChild.payment = 0.0
        
        do {
            try realm.write {
                realm.add(newChild)
            }
        } catch {
            print("Error saving: \(error)")
        }
        
    }
}

