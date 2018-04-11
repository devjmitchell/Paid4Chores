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

    var children: Results<Child>?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        children = realm.objects(Child.self)
    }

    @IBAction func addChildTapped(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Child", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            self.saveChild(named: textField.text!)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Little Jimmy"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveChild(named: String) {
        
        let newChild = Child()
        newChild.name = named
        
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
        return children?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildCell", for: indexPath) as! ChildCell

        if let child = children?[indexPath.row] {
            cell.childNameLabel.text = child.name
        }
        
        return cell
        
    }
    
}

