//
//  ViewController.swift
//  ArtBookProject
//
//  Created by Mac on 26.12.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var paintingModel = [PaintingModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    
        //navigation controllar;
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(rightBarButtonItem))
        
        // get data via Core Data;
        getData()
        
    }
    //Core Data Geting Datas
    func getData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        //for more performans usage this can be made false;
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
          let results =  try context.fetch(fetchRequest)
            for item in results as! [NSManagedObject] {
                if let name = item.value(forKey: "name") as? String, let id = item.value(forKey: "id") as? UUID{
                    paintingModel.append(PaintingModel(name:name,id:id))
                }
            }
            self.tableView.reloadData()
        } catch  {
            print("some error occur \(error)")
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paintingModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = paintingModel[indexPath.row].name
        return cell
    }
    
    
    
    
    
   @objc func rightBarButtonItem() {
    performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
         let  destinationVC = segue.destination as! DetailsViewController
            //destinationVC
        }
    }

}

