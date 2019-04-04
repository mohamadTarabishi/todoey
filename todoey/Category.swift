//
//  Category.swift
//  todoey
//
//  Created by Mohamad Tarabishi on 4/2/19.
//  Copyright © 2019 Mohamad Tarabishi. All rights reserved.
//

import Foundation
import RealmSwift


class Category: Object {
    @objc dynamic var name : String = ""
    let Items = List<Item>()
    
    
}
