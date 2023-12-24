//
//  LocationSelectionViewController.swift
//  phw11-1-userSettingController
//
//  Created by jasonhung on 2023/12/25.
//

import UIKit

protocol LocationSelectionViewControllerDelegate: AnyObject {
    func didSelectLocation(_ location: String)
}


class LocationSelectionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var locationPickerView: UIPickerView!
    
    weak var delegate: LocationSelectionViewControllerDelegate?
    
    
    // 台灣的縣市資料
    let taiwanCities = ["基隆市", "台北市", "新北市", "桃園市", "新竹市", "新竹縣", "苗栗縣", "台中市", "彰化縣", "南投縣", "雲林縣", "嘉義市", "嘉義縣", "台南市", "高雄市", "屏東縣", "台東縣", "花蓮縣", "宜蘭縣", "澎湖縣", "金門縣", "連江縣"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 設定 UIPickerView 的代理和數據源
        locationPickerView.delegate = self
        locationPickerView.dataSource = self
    }
    
    // MARK: - UIPickerViewDelegate and UIPickerViewDataSource Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 一個區域
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return taiwanCities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return taiwanCities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCity = taiwanCities[row]
        print("選擇了 \(selectedCity)")
    }
    
    
    @IBAction func didTapConfirmButton(_ sender: UIButton) {
        // 取得選中的縣市字串
        let selectedRow = locationPickerView.selectedRow(inComponent: 0)
        let selectedCity = taiwanCities[selectedRow]
        
        // 通知代理，用戶選擇了縣市
        delegate?.didSelectLocation(selectedCity)
        
        // 關閉 LocationSelectionViewController
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
}

