//
//  ViewController.swift
//  phw11-1-userSettingController
//
//  Created by jasonhung on 2023/12/25.
//

import UIKit
import SafariServices
//import AVKit
//import MessageUI

class userSettingViewController: UIViewController,
                                 UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIColorPickerViewControllerDelegate{
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var mediumIdTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userPhotoImageView.layer.cornerRadius = 60
    }
    
    
    
    @IBAction func selectProfileImage(_ sender: Any) {
        // 創建 UIImagePickerController 實例
        let imagePicker = UIImagePickerController()
        // 設定代理為當前視圖控制器，以接收照片選擇相關事件
        imagePicker.delegate = self
        // 設定來源為相冊
        imagePicker.sourceType = .photoLibrary
        // 呈現相冊選擇器
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    // 使用者選擇照片後的回調函數
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 從info中獲取原始照片
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // 將選擇的照片設定給 userPhotoImageView
            userPhotoImageView.image = pickedImage
        }
        
        // 關閉相冊選擇器
        dismiss(animated: true, completion: nil)
    }
    
    // 使用者取消選擇照片的回調函數
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 關閉相冊選擇器
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - 選地點
    @IBAction func showLocationPicker(_ sender: Any) {
        // 創建 LocationSelectionViewController 實例
        //let locationSelectionVC = LocationSelectionViewController()
        // 使用 storyboard identifier 載入 LocationSelectionViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil) // 替換 "Main" 為你的 storyboard 名稱
        if let locationSelectionVC = storyboard.instantiateViewController(withIdentifier: "LocationSelectionViewController") as? LocationSelectionViewController {
            
            
            // 設定 LocationSelectionViewController 的代理，以接收選擇事件
            locationSelectionVC.delegate = self
            
            // 使用 navigationController 來 present
            let navController = UINavigationController(rootViewController: locationSelectionVC)
            present(navController, animated: true, completion: nil)
        }
    }
    

    
    
    // MARK: - 顯示地圖
    
    @IBAction func showLocationMap(_ sender: UIButton) {
        
        // 檢查是否有選擇的位置
        guard let selectedLocation = locationLabel.text else {
            // 如果沒有選擇位置，顯示警告或執行其他操作
            return
        }

        // 跳轉到地圖視圖
        if let mapViewController = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
            mapViewController.selectedLocation = selectedLocation
            present(mapViewController, animated: true, completion: nil)

        }
    }
    
    // MARK: - 在字典裡查名字
    @IBAction func nameReferenceLibrary(_ sender: UIButton) {
        let controller = UIReferenceLibraryViewController(term: userNameTextField.text!)
        present(controller, animated: true)
    }
    
    
    // MARK: - 打開網站
    @IBAction func openMediumWebsite(_ sender: Any) {
        let id:String = mediumIdTextField.text!
        let url = URL(string: "https://medium.com/\(id)")!
        print(url)
                let safariViewController = SFSafariViewController(url: url)
                present(safariViewController, animated: true, completion: nil)
    }
    
    @IBAction func showColorPicker(_ sender: UIButton) {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true, completion: nil)
    }
    
    // 實作 UIColorPickerViewControllerDelegate 方法
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        view.backgroundColor = viewController.selectedColor
    }
    
}

// MARK: - 選地點 Delegate
// 採納 LocationSelectionViewControllerDelegate 協定
extension userSettingViewController: LocationSelectionViewControllerDelegate {
    func didSelectLocation(_ location: String) {
        // 將選中的縣市字串填回 label
        locationLabel.text = location
    }
}
