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
    
//    var children = Results<Child>.self // [Child]()
//    let children = [Child]()
    var children: Results<Child>?
    
    let testArray = ["One", "Two", "Three"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadChildren()
    }

    @IBAction func addChildTapped(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Child", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            self.saveChild(named: textField.text!)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Jimmy"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func loadChildren() {
        children = realm.objects(Child.self)
        tableView.reloadData()
    }
    
    func saveChild(named: String) {
        
        let newChild = Child()
        newChild.name = named
//        newChild.payment = 0.0
        
        do {
            try self.realm.write {
                self.realm.add(newChild)
            }
        } catch {
            print("Error saving: \(error)")
        }
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return testArray.count
//        return children?.count ?? 1
        return children?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildCell", for: indexPath) as! ChildCell
        
//        let childName = testArray[indexPath.row]
//        let childName = children[indexPath.row].name
//        cell.childNameLabel.text = childName
        
        let child = children![indexPath.row]
        cell.childNameLabel.text = child.name
        
        return cell
        
    }
    
}

