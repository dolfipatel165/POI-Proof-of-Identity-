//
//  insertPage.swift
//  poi
//
//  Created by MacStudent on 2017-07-25.
//  Copyright © 2017 Utsav. All rights reserved.
//

import UIKit
import CoreData

class insertPage: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var noTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var cityTxtField: UITextField!
    @IBOutlet weak var latitudeTxtField: UITextField!
    @IBOutlet weak var longitudeTxtField: UITextField!
    @IBOutlet weak var descriptionTxtField: UITextField!
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        secondView.layer.cornerRadius = 10 ;
        
        
        // ==============pickerview===================
        
        let myPicker = UIPickerView()
        myPicker.delegate = self
        categoryTxt.inputView = myPicker
        // ----------toolbar-----------
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        
        toolBar.tintColor = UIColor.white
        
        toolBar.backgroundColor = UIColor.black
        
        let defaultButton = UIBarButtonItem(title: "Default", style: UIBarButtonItemStyle.plain, target: self, action: #selector(insertPage.tappedToolBarBtn))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(insertPage.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Marker Felt", size: 12)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.text = "Pick one Place"
        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([defaultButton,flexSpace,textBtn,flexSpace,doneButton], animated: true)
        
        categoryTxt.inputAccessoryView = toolBar
        
        //===========================================
        
    }
    
    
    //======= Picker view=======
    @IBOutlet weak var categoryTxt: UITextField!
    //@IBOutlet weak var myPickerView: UIPickerView!
    
    func donePressed(sender: UIBarButtonItem) {
        
        
        categoryTxt.resignFirstResponder()
        
    }
    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        
        categoryTxt.text = "Hotel"
        
        categoryTxt.resignFirstResponder()
    }
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    var list = ["Hotel","Park","Hospital","School","Shopping Mall"];
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTxt.text = list[row]
        
    }
    

    //=====image Picker========
    @IBOutlet weak var theImage: UIImageView!
    @IBOutlet weak var secondView: UIView!
    
    @IBAction func chooseImg(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
        {
            
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            theImage.image = image
        }
        else {
            //error image
        }
        self.dismiss(animated: true, completion: nil)
    }

    //===============================
    
    @IBAction func insertBtnClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        
        let no : Int16 = Int16(noTxtField.text!)!
        let name : String = String(nameTxtField.text!)!
        let city : String = String(cityTxtField.text!)!
        let latitude : Double = Double(latitudeTxtField.text!)!
        let longitude : Double = Double(longitudeTxtField.text!)!
        let category : String = String(categoryTxt.text!)!
        let img = theImage.image
        let description : String = String(descriptionTxtField.text!)!
        
        newPlace.setValue(no, forKey: "no")
        newPlace.setValue(name, forKey: "name")
        newPlace.setValue(city, forKey: "city")
        newPlace.setValue(latitude, forKey: "latitude")
        newPlace.setValue(longitude, forKey: "longitude")
        newPlace.setValue(category, forKey: "category")
        newPlace.setValue(description, forKey: "desc")
        
        let imgData = UIImageJPEGRepresentation(img!,1)
        newPlace.setValue(imgData, forKey: "image")
        noTxtField.text = ""
        nameTxtField.text = ""
        cityTxtField.text = ""
        latitudeTxtField.text = ""
        longitudeTxtField.text = ""
        descriptionTxtField.text = ""
        categoryTxt.text = ""
        do{
            try context.save()
            print("Saved!")
        } catch {
            print(error.localizedDescription)
        }
        

    }
    
    
    
}
