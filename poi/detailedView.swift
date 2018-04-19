//
//  detailedView.swift
//  poi
//
//  Created by Dolfi Patel on 2017-07-28.
//  Copyright © 2017 Utsav. All rights reserved.
//

import UIKit

class detailedView: UIViewController {

    var getNo : String = ""
    var getCityName : String = ""
    var getLat : Double = 0.0
    var getLong : Double = 0.0
    var getcat : String = ""
    var getdisc : String = ""
    var getPlaceName : String = ""
    var getImage : UIImage!
    
    var passLat : Double = 0.0
    var passLong : Double = 0.0
    var passCityName : String = ""
    var passPalceName : String = ""
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var noLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var longitudeLbl: UILabel!
    @IBOutlet weak var latitudeLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var placeImg: UIImageView!
    
    @IBOutlet weak var descriptionLbl: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = getPlaceName
        noLbl.text = getNo
        descriptionLbl.text = getdisc
        latitudeLbl.text = String(getLat)
        longitudeLbl.text = String(getLong)
        categoryLbl.text = getcat
        cityLbl.text = getCityName
        placeImg.image = getImage
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mapBtnClicked(_ sender: Any) {
        let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "mapVC") as! mapView
        passLat = getLat
        passLong = getLong
        passCityName = getCityName
        passPalceName = getPlaceName
        
        mapVC.getLat = passLat
        mapVC.getLong = passLong
        mapVC.getPlaceName = passPalceName
        self.present(mapVC, animated: true, completion: nil)

        //[self .performSegue(withIdentifier: "mapSegue", sender: self)]
    }
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//                if (segue.identifier == "mapSegue") {
//                    let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "mapVC") as! mapView
//
//                    mapVC.getLat = passLat
//                    mapVC.getLong = passLong
//
//                }
//            }
//
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

        
    }

}
