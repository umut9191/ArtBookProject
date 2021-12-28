//
//  ViewController.swift
//  ArtBookProject
//
//  Created by Mac on 26.12.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //navigation controllar;
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(rightBarButtonItem))
        
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

