//
//  PlanetaDao.swift
//  Planeta
//
//  Created by Aplimovil on 12/8/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import Foundation
import SQLite

class PlanetaDao{
    
    var db:Connection!
    let table = Table("planeta")
    let id = Expression<Int64>("id")
    let nombre = Expression<String>("nombre")
    let gravedad = Expression<Double>("gravedad")
    
    init(){
        do{
            let path = NSSearchPathForDirectoriesInDomains(
                .DocumentDirectory, .UserDomainMask, true
                ).first!
            
            db = try Connection("\(path)/planeta.sqlite3")
            try db!.run(table.create(ifNotExists:true){ t in
                t.column(id, primaryKey: true)
                t.column(nombre)
                t.column(gravedad)
                })
            
        }catch{
            db = nil
        }
        
    }
    
    func insert(p:Planeta)->Int64{
        let insert = table.insert(nombre <- p.nombre, gravedad <- p.gravedad)
        
        do{
            return try db.run(insert)
        }catch{
            return -1
        }
    }
    
    func update(p:Planeta){
        let filter = table.filter(id == p.id)
        let update = filter.update(nombre <- p.nombre, gravedad <- p.gravedad)
        
        do{
            try db.run(update)
        }catch{
        }
        
    }
    
    func delete(p:Planeta){
        let filter = table.filter(id == p.id)
        do{
            try db.run(filter.delete())
        }catch{
        }
        
        
    }

    func findById(idPlaneta:Int64)->Planeta?{
        let filter = table.filter(id == idPlaneta)
        let data = db.prepare(filter)
        var row:Row?
        
        
        for r  in data {
            row = r
            break
        }
        
        return rowToPlaneta(row)
    }
    
    func getAll()->[Planeta]{
        return rowsToList(db.prepare(table))
    
    }
    
    func getAllByNombre(nombre:String)->[Planeta]{
        
        return statementToList(db.prepare("SELECT * FROM planeta WHERE nombre LIKE '%\(nombre)%'",nil))
    }
    
    
    
    private func rowsToList(rows:AnySequence<Row>)->[Planeta]{
        var data:[Planeta] = [Planeta]()
        
        for r in rows{
            data.append(rowToPlaneta(r)!)
        }
        
        return data
    }
    
    private func rowToPlaneta(row:Row? )->Planeta?{
        if row == nil{
            return nil
        }else{
            let p:Planeta =  Planeta()
            p.id = row![id]
            p.nombre = row![nombre]
            p.gravedad = row![gravedad]
            return p
        }
    }
    
    private func statementToList(s:Statement)->[Planeta]{
        var data:[Planeta] = [Planeta]()
        
        for r in s{
            let p:Planeta = Planeta()
            p.id = r[0] as! Int64
            p.nombre = "\(r[1])"
            p.gravedad = r[2] as! Double
            
            data.append(p)
        }
        
        return data

    }
    
}