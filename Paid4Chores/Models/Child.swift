//
//  Child.swift
//  Paid4Chores
//
//  Created by Jason Mitchell on 4/11/18.
//  Copyright © 2018 Jason Mitchell. All rights reserved.
//

import Foundation
import RealmSwift

class Child: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var payment: Float = 0.0
}
