//
//  UserStorage.swift
//  Xuan_Hanh
//
//  Created by ikame on 8/5/25.
//

class UserStorage {
    static var shared = UserStorage()
    private init() {}

    var users: [User] = []
    
    func remove(user: User) {
            users.removeAll { $0.firstName == user.firstName && $0.lastName == user.lastName && $0.height == user.height && $0.weight == user.weight && $0.gender == user.gender }
        }
}
