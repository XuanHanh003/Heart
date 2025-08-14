//
//  UserObject.swift
//  Xuan_Hanh
//
//  Created by ikame on 8/14/25.
//

import RealmSwift

class UserObject: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
    @Persisted var gender: String = ""
    @Persisted var height: Int = 0
    @Persisted var weight: Int = 0
}
