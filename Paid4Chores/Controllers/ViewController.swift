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
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
        
        if let addToPayment = children?[selectedRow] {
            do {
                try realm.write {
                    addToPayment.payment += 0.25
                }
            } catch {
                print("Error updating: \(error)")
            }
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
            cell.paymentLabel.setTitle(String(child.payment), for: .normal)
        }
        
        cell.delegate = self
        
        return cell
        
    }
    
}

extension ViewController: ChildCellDelegate {

    func didTapPaymentButton(_ sender: ChildCell) {
        let tappedIndexPath = tableView.indexPath(for: sender)?.row

        if let updateChild = children?[tappedIndexPath!] {
            do {
                try realm.write {
                    updateChild.payment = 0.0
                }
            } catch {
                print("Error updating: \(error)")
            }
        }
        
        tableView.reloadData()
    }

}












