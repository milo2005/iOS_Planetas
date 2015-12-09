//
//  Planeta.swift
//  Planeta
//
//  Created by Aplimovil on 12/8/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import Foundation

class Planeta {
    
    var id:Int64
    var nombre:String
    var gravedad:Double
    
    init(){
        nombre = ""
        gravedad = 0
        id = 0
    }
    
    init(nombre:String, gravedad:Double){
        self.nombre = nombre
        self.gravedad = gravedad
        self.id = 0
    }
    
}
