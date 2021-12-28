//
//  PaintingModel.swift
//  ArtBookProject
//
//  Created by Mac on 29.12.2021.
//

import Foundation

class PaintingModel {
    let name: String
    let id:UUID
    
    init(name:String,id:UUID) {
        self.name = name
        self.id = id
    }
}
