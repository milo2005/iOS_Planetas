//
//  AddPlanetaViewController.swift
//  Planeta
//
//  Created by Aplimovil on 12/8/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit

class AddPlanetaViewController: UIViewController {
    
    var list:ViewController!
    var pos:Int?
    var planetaDao:PlanetaDao!
    
    @IBOutlet var nombre:UITextField!
    @IBOutlet var gravedad:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        if(pos != nil){
            self.title = "Editar"
            nombre.text = list.data[pos!].nombre
            gravedad.text = "\(list.data[pos!].gravedad)"
        }
        planetaDao = PlanetaDao()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePlaneta(sender:AnyObject){
        
        if(pos != nil){
            list.data[pos!].gravedad = Double(gravedad.text!)!
            list.data[pos!].nombre = nombre.text!
            
            planetaDao.update(list.data[pos!])
            
        }else{
            let p:Planeta = Planeta()
            p.nombre = nombre.text!
            p.gravedad = Double(gravedad.text!)!
            
            list.data.append(p)
            planetaDao.insert(p)
        }
        
        self.navigationController?.popToViewController(list, animated: true)
        
    }
    
}
