//
//  Movie.swift
//  movsea
//
//  Created by Movsea Team on 4/28/16.
//  Copyright © 2017 Movsea Team.
//

import RealmSwift
import ObjectMapper

class Movie: Object, Mappable {
    
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var country = ""
    @objc dynamic var year = ""
    @objc dynamic var directors = ""
    @objc dynamic var stars = ""
    @objc dynamic var movieDescription = ""
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var syncDate = Date()

    @objc dynamic var isMovieStatsSent = false
    
    //URLS in future
    @objc dynamic var poster = ""
    @objc dynamic var trailer = ""
    @objc dynamic var buyMovie = ""

    
    class func getAllFindings() -> [Movie] {

        let realm = try! Realm()
        let movieList = realm.objects(Movie.self)

        return Array(movieList)
        
    }
    
    func deleteObject() {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(self)
        }
    }
    
    func processFilmStatsSending() {
        let realm = try! Realm()
        try! realm.write {
            self.isMovieStatsSent = true
        }
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        country <- map["productionCountry"]
        year <- map["year"]
        directors <- map["director"]
        stars <- map["stars"]
        movieDescription <- map["description"]
        rating <- map["rating"]
        poster <- map["poster"]
        trailer <- map["trailer"]
        buyMovie <- map["buyMovie"]
    }
}
