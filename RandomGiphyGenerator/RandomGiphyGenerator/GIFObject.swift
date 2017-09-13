//
//  GIFObject.swift
//  RandomGiphyGenerator
//
//  Created by Rutkoski,Augustus on 9/13/17.
//  Copyright © 2017 heb. All rights reserved.
//

import Foundation
import ObjectMapper

class GIFObject: Mappable {
    
    var data: GIFData?
    
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        data <- map["data"]
    }
}

class GIFData: Mappable {
    
    var image_url: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        image_url <- map["fixed_height_downsampled_url"]
    }
}


