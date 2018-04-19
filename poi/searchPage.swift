//
//  searchPage.swift
//  poi
//
//  Created by Dolfi Patel on 2017-07-25.
//  Copyright © 2017 Utsav. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class searchPage: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var myView: UIView!
    //@IBOutlet weak var secondPicker: UIPickerView!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var searchByCat: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var cancleBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backViewOfContainer: UIView!
    var list = ["Hotel","Park","Hospital","School","Shopping Mall"];
    var cityList = [String]();

    var myPicker = UIPickerView()
    var picker = UIPickerView()
    
    
    override func viewDidLoad() {
        hiddenView.isHidden = true
        myTableView.delegate = self
        myTableView.dataSource = self
        cancleBtn.layer.cornerRadius = 15
        cancleBtn.isHidden = true
        arrayfetch()

        super.viewDidLoad()
        
        backView.isHidden = true
        
//         myPicker = UIPickerView()
//         picker = UIPickerView()
        
        myPicker.tag = 1;
        picker.tag = 2;
        
        
        myPicker.delegate = self
        picker.delegate=self
        
        cityTxt.inputView = myPicker
        searchByCat.inputView = picker
        
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

        label.text = "Pick one Category"

        label.textAlignment = NSTextAlignment.center

        let textBtn = UIBarButtonItem(customView: label)

        toolBar.setItems([defaultButton,flexSpace,textBtn,flexSpace,doneButton], animated: true)
        cityTxt.inputAccessoryView = toolBar
        

    }

    func arrayfetch() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        let requst = NSFetchRequest<NSFetchRequestResult> (entityName: "Places")
        
        
        
        do{
        let fetchData = try context.fetch(requst)
        
            if fetchData.count>0
            {
                for dpt in fetchData as! [NSManagedObject]
                {
                    
                    let city  = dpt.value(forKey: "city") as! String
                    cityList.append(city)
                }
            }
            
            //print("\(placeName)")
        }
        catch{
            
        }
        
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //======= Picker view=======
    @IBOutlet weak var categoryTxt: UITextField!
    //@IBOutlet weak var myPickerView: UIPickerView!
    
    
    //==============================
    func donePressed(sender: UIBarButtonItem) {
        cityTxt.resignFirstResponder()
        searchByCat.resignFirstResponder()
    }
    
    func done(sender: UIBarButtonItem) {
        searchByCat.resignFirstResponder()
    }
    //=============================
    func otherBtn(sender: UIBarButtonItem) {
        searchByCat.text = "toronto"
        searchByCat.resignFirstResponder()
    }
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        
    
        cityTxt.text = "Hotel"
        
        cityTxt.resignFirstResponder()
    }
    //=============================
    
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    func touches(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView.tag == 1 {
            return cityList.count
        }else{
            
        return list.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return cityList[row]
        }else{
        return list[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            cityTxt.text = cityList[row]

        }else{
           searchByCat.text = list[row]
        }
    }

//========================================
    

    var passCityName : String = ""
    var passNo : String = ""
    var passLat : Double = 0.0
    var passLong : Double = 0.0
    var passCat : String = ""
    var passDisc : String = ""
    var passPlaceName : String = ""
    var passImage : UIImage!
    //========================================
    var placeName = [String]()
    var placeImageAry = [UIImage]()
    var tempImg : UIImage? = nil
    var noAry = [Int16]()
    var nameAry = [String]()
    var cityAry = [String]()
    var latAry = [Double]()
    var longAry = [Double]()
    var catAry = [String]()
    var discAry = [String]()
    
    var temp :Int = 0
    //======================================
    @IBAction func okBtnCity(_ sender: Any) {
        hiddenView.isHidden = false
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeName.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.myTableView.dequeueReusableCell(withIdentifier: "cell11")!
        
        (cell.contentView.viewWithTag(1) as! UILabel).text = placeName[indexPath.row]
        
        
        (cell.contentView.viewWithTag(2) as! UIImageView).image = placeImageAry[indexPath.row]
        
    
        return cell
    }
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")

        let detailedVC = self.storyboard?.instantiateViewController(withIdentifier: "detailedView") as! detailedView
        passCityName = cityAry[indexPath.row]
        passLat = latAry[indexPath.row]
        passLong = longAry[indexPath.row]
        passDisc = discAry[indexPath.row]
        passCat = catAry[indexPath.row]
        passNo = String(noAry[indexPath.row])
        passPlaceName = nameAry[indexPath.row]
        passImage = placeImageAry[indexPath.row]

        print(passCityName)
        print(passLat)
        print(passLong)
        print(passDisc)
        print(passCat)
        print(passNo)
        print(passPlaceName)

        detailedVC.getCityName = passCityName
        detailedVC.getcat = passCat
        detailedVC.getLong = passLong
        detailedVC.getLat = passLat
        detailedVC.getdisc = passDisc
        detailedVC.getNo = passNo
        detailedVC.getPlaceName = passPlaceName
        detailedVC.getImage = passImage
        
        self.present(detailedVC, animated: true, completion: nil)
    }
    @IBAction func searchByCityBtn(_ sender: Any) {
                backView.isHidden = false
                containerView.isHidden = true
        backViewOfContainer.isHidden = true
        cancleBtn.isHidden = false

               let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
        
        
                let requst = NSFetchRequest<NSFetchRequestResult> (entityName: "Places")
        
        
                do {
                    let fetchData = try context.fetch(requst)
                    if fetchData.count>0
                    {
                        for dpt in fetchData as! [NSManagedObject]
                        {
                            
                            let city  = dpt.value(forKey: "city") as! String
                            if cityTxt.text == city {
                                placeName.append(city)
                                noAry.append(dpt.value(forKey: "no") as! Int16)
                                nameAry.append(dpt.value(forKey: "name") as! String)
                                cityAry.append(dpt.value(forKey: "city") as! String)
                                latAry.append(dpt.value(forKey: "latitude") as! Double)
                                longAry.append(dpt.value(forKey: "longitude") as! Double)
                                discAry.append(dpt.value(forKey: "desc") as! String)
                                catAry.append(dpt.value(forKey: "category") as! String)
                                
                                if let imgData = dpt.value(forKey: "image") as? NSData{
                                    if let img = UIImage(data: imgData as Data) as UIImage!{
                                        // imageView.image = img
                                        tempImg = img
                                        placeImageAry.append(tempImg!)

                                    }
                                }

                            
                            }
                    }
        
                         print("\(placeName)")
            }
            else
            {
            }
        }
                catch
                {
                    fatalError("Faild to fetch DeptTable")
                }
        myTableView.reloadData()
        myView.isHidden = false
        
        
        
}
    @IBAction func searchByCatBtnClicked(_ sender: Any) {
    backView.isHidden = false
    picker.isHidden = true
    cancleBtn.isHidden = false
searchByCat.resignFirstResponder()
        backViewOfContainer.isHidden = true
        containerView.isHidden = true
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    
    let requst = NSFetchRequest<NSFetchRequestResult> (entityName: "Places")
    
    
    do {
    let fetchData = try context.fetch(requst)
    if fetchData.count>0
    {
    for dpt in fetchData as! [NSManagedObject]
    {
    
    let category  = dpt.value(forKey: "category") as! String
    if searchByCat.text == category {
        
    placeName.append(dpt.value(forKey: "name") as! String)
    noAry.append(dpt.value(forKey: "no") as! Int16)
    nameAry.append(dpt.value(forKey: "name") as! String)
    cityAry.append(dpt.value(forKey: "city") as! String)
    latAry.append(dpt.value(forKey: "latitude") as! Double)
    longAry.append(dpt.value(forKey: "longitude") as! Double)
    discAry.append(dpt.value(forKey: "desc") as! String)
    catAry.append(dpt.value(forKey: "category") as! String)
    
    if let imgData = dpt.value(forKey: "image") as? NSData{
    if let img = UIImage(data: imgData as Data) as UIImage!{
    // imageView.image = img
    tempImg = img
    placeImageAry.append(tempImg!)
    
                }
            }
        }
    }
    
    print("\(placeName)")
    }
    
    }
    catch
    {
    fatalError("Faild to fetch DeptTable")
    }
    myTableView.reloadData()
    myView.isHidden = false
    }
    @IBAction func cancleBtnClicked(_ sender: Any) {
        hiddenView.isHidden = true
        containerView.isHidden = false
        backViewOfContainer.isHidden = false
        cancleBtn.isHidden = true
        backView.isHidden = true
        picker.isHidden = false
        placeName = []
        noAry = []
        nameAry = []
        cityAry = []
        placeImageAry = []
        tempImg = nil
        latAry = []
        longAry = []
        catAry = []
        discAry = []
        searchByCat.text = ""
        cityTxt.text = ""
        
//        var placeName = [String]()
//        var placeImageAry = [UIImage]()
//        var tempImg : UIImage? = nil
//        var noAry = [Int16]()
//        var nameAry = [String]()
//        var cityAry = [String]()
//        var latAry = [Double]()
//        var longAry = [Double]()
//        var catAry = [String]()
//        var discAry = [String]()
        
        
        myTableView.reloadData()
    }

}
