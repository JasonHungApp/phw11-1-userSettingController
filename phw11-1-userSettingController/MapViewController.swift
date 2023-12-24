//
//  MapViewController.swift
//  phw11-1-userSettingController
//
//  Created by jasonhung on 2023/12/25.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    var selectedLocation: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 其他初始化設定...
        locationLabel.text = selectedLocation
        
        // 檢查是否有選擇的位置
        if let selectedLocation = selectedLocation {
            // 使用 CLGeocoder 將地址轉換為座標
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(selectedLocation) { (placemarks, error) in
                if let error = error {
                    print("Geocoding error: \(error.localizedDescription)")
                } else if let placemark = placemarks?.first {
                    // 獲取地點的座標
                    let coordinate = placemark.location?.coordinate
                    
                    // 在地圖上顯示標記
                    if let coordinate = coordinate {
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinate
                        annotation.title = selectedLocation
                        self.mapView.addAnnotation(annotation)
                        
                        // 移動地圖視圖以顯示標記，// 調整地圖視圖的縮放比例
                        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
                        self.mapView.setRegion(region, animated: true)
                    }
                }
            }
        }
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}
