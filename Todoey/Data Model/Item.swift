//
//  Item.swift
//  Todoey
//
//  Created by Steven Gong on 2018-02-27.
//  Copyright © 2018 GongLiang. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var ParentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
