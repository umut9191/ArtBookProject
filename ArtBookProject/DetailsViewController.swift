//
//  DetailsViewController.swift
//  ArtBookProject
//
//  Created by Mac on 28.12.2021.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //closing the keyboard after clicking somewhere else on the screen;
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        // another gesturerecognizer for clicking to image and opening galery for selecting an image;
        imageView.isUserInteractionEnabled = true
        let gestureRecognizerImage = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(gestureRecognizerImage)
    }
    @objc func imageTapped(){
        // for reaching user galery image,video ext.
        //we use picer;
        let picker = UIImagePickerController()
        picker.delegate = self
        //camera or photo library or album;
        picker.sourceType = .photoLibrary
        //making zoom vs.
        picker.allowsEditing =  true
        present(picker, animated: true, completion: nil)
        
    }
    //after image selection we use UIImagePickerControllerDelegate for call a function doing something;
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //here original image or editing image mostly uses ; we said abowe we gonna edit image yes. thats  just for knowing there is something like that.
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
        //Not: we know we can ask user permision for reaching his/her galery;
        //it is not obligation like before but doing this is good thing.
        //for doing that we are using Info.plist file
        //just going there and click any add button and select photo library usage and write right side description about it.
        //we did but because of version maybe not working.
    }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        //here Core Data things;
        //after we use add core data while creating this project some code otomaticaly came to AppDelegate such context.
        //we gona reacht that context for crud operations;
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //for reaching entities;
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
      
        //saving data; Attributes
        newPainting.setValue(nameText.text!, forKey: "name")
        newPainting.setValue(artistText.text!, forKey: "artist")
        if let year = Int(yearText.text!){
            newPainting.setValue(year, forKey: "year")
        }
        newPainting.setValue(UUID(), forKey: "id")
        //image;
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        // saving;
        do {
            try context.save()
        } catch  {
            print("some error ocur \(error)")
        }

        
        
    }
}
