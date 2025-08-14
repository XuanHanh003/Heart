//
//  DB.swift
//  Xuan_Hanh
//
//  Created by ikame on 8/14/25.
//

import RealmSwift

enum DB {
    static var realm: Realm { try! Realm() }

    static func write(_ block: (Realm) -> Void) {
        let r = realm
        try! r.write { block(r) }
    }
}
