//
//  mapView.swift
//  poi
//
//  Created by Dolfi Patel on 2017-07-28.
//  Copyright © 2017 Utsav. All rights reserved.
//

import UIKit
import MapKit

class mapView: UIViewController {

    var getLat : Double = 43.7732574
    var getLong : Double = -79.3380826
    var getPlaceName : String = ""
    var getCityName : String = ""
    var temp : String = "in "
    @IBOutlet weak var myMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let location = CLLocationCoordinate2D(latitude: getLat,longitude: getLong)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        
        myMapView.setRegion(region, animated: true)
        
        // 4)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = getPlaceName
        annotation.subtitle = getCityName
        myMapView.addAnnotation(annotation)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        //let detailedVC = self.storyboard?.instantiateViewController(withIdentifier: "detailedView") as! detailedView
        self.dismiss(animated: true, completion: nil)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
