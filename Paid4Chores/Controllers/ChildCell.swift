//
//  ChildCell.swift
//  Paid4Chores
//
//  Created by Jason Mitchell on 4/11/18.
//  Copyright © 2018 Jason Mitchell. All rights reserved.
//

import UIKit
import RealmSwift

protocol ChildCellDelegate {
    func didTapPaymentButton(_ sender: ChildCell)
}

class ChildCell: UITableViewCell {
    
    @IBOutlet weak var childNameLabel: UILabel!
    @IBOutlet weak var paymentLabel: UIButton!
    
    var delegate: ChildCellDelegate?
    
    @IBAction func paymentButtonTapped(_ sender: UIButton) {
        delegate?.didTapPaymentButton(self)
    }
}
