//
//  PostoAnnotation.swift
//  MeuCombustivel
//
//  Created by alunor17 on 04/05/17.
//  Copyright © 2017 Comar Ltda. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class PostoAnnotation: NSObject, MKAnnotation {
    var id:Int = 0
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var ref: FIRDatabaseReference?
    var name:String? {
        get {
            return self.title
        }
    }
    
    init(name:String?, coordinate:CLLocationCoordinate2D) {
        self.title = name
        self.coordinate = coordinate
    }
    
    func toAnyObject() -> Any {
        return ["id":self.id,"lat":Float(coordinate.latitude), "long":Float(coordinate.longitude), "name":self.title!]
    }
}
