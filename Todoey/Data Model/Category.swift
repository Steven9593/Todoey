//
//  Category.swift
//  Todoey
//
//  Created by Steven Gong on 2018-02-27.
//  Copyright © 2018 GongLiang. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
