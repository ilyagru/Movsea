//
//  User.swift
//  movsea
//
//  Created by Movsea Team on 10/12/16.
//  Copyright © 2017 Movsea Team.
//


import RealmSwift

class User: Object {
    
    @objc dynamic var isAgreed: Bool = false
    
    class func getUser() -> User {
        let realm = try! Realm()
        var user = realm.objects(User.self).first
        if user == nil {
            user = User()
            try! realm.write {
                realm.add(user!)
            }
        }
        
        return user!
    }
    
    class func agreeWithTerms() {
        let realm = try! Realm()
        try! realm.write {
            User.getUser().isAgreed = true
        }
    }

}
