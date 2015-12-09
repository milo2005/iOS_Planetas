//
//  ViewController.swift
//  Planeta
//
//  Created by Aplimovil on 12/8/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var data:[Planeta] = [Planeta]()
    var planetaDao:PlanetaDao!
    @IBOutlet var table:UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        planetaDao = PlanetaDao()
        
        data = planetaDao.getAll()
        
        /*var p:Planeta = Planeta()
        p.nombre = "test1"
        p.gravedad = 3.5
        data.append(p)
        
        p = Planeta()
        p.nombre = "test2"
        p.gravedad = 9.8
        data.append(p)*/
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Datasource TableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:PlanetaTableViewCell! = tableView.dequeueReusableCellWithIdentifier("cell") as! PlanetaTableViewCell
        
        let p:Planeta = data[indexPath.row]
        
        cell.nombre.text = p.nombre
        cell.gravedad.text = "\(p.gravedad)"
        
        return cell
        
    }
    
    //MARK: - CRUD Actions
    
    @IBAction func editPlaneta(sender:AnyObject){
        
        if(table.indexPathForSelectedRow == nil){
            self.showUnselectedMessage("Editar Planeta")
        }else{
            performSegueWithIdentifier("edit", sender: nil)
        }
        
    }
    
    @IBAction func deletePlanetaAlert(sender:AnyObject){
        
        if(table.indexPathForSelectedRow == nil){
            self.showUnselectedMessage("Eliminar Planeta")
        }else{
            showDeletePlaneta()
        }
        
    }
    
    func showDeletePlaneta(){
        
        let p:Planeta = data[(table.indexPathForSelectedRow?.row)!]
        
        let alert:UIAlertController = UIAlertController(title: "Eliminar Planeta", message: "Desea eliminar el planeta \(p.nombre)", preferredStyle: UIAlertControllerStyle.Alert)
        
        let actionOk:UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
        self.planetaDao.delete(self.data[(self.table.indexPathForSelectedRow?.row)!])
            self.data.removeAtIndex((self.table.indexPathForSelectedRow?.row)!)
            self.table.reloadData()
            
        }
        
        let actionCancel:UIAlertAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func showUnselectedMessage(title:String){
        
        let alert:UIAlertController = UIAlertController(title: title, message: "Seleccione un planeta", preferredStyle: UIAlertControllerStyle.Alert)
        
        let action:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(action)
       
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let nextPlaneta:AddPlanetaViewController = segue.destinationViewController as! AddPlanetaViewController
        
        
        if(segue.identifier == "edit"){
            nextPlaneta.pos = table.indexPathForSelectedRow?.row
        }
        
        nextPlaneta.list = self
        
        
    }


}

