//
//  Pockemon.swift
//  
//
//  Created by Mike on 3/27/19.
//

import UIKit

class Pockemon {
    var latitude:Double?
    var longitude:Double?
    var image:String?
    var name:String?
    var des:String?
    var power:Double?
    var isCatch:Bool?
    init(latitude:Double, longitude:Double, image:String, name:String,  des:String, power:Double) {
        self.latitude=latitude
        self.longitude=longitude
        self.image=image
        self.name=name
        self.des=des
        self.power=power
        //self.isCatch=false
}
}
