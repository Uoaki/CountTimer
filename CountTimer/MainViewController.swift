//
//  ViewController.swift
//  CountTimer
//
//  Created by 파루파루상 on 2024/09/07.
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickUpSecond: UIPickerView!
    @IBAction func resetButton(_ sender: UIButton) {
        pickUpSecond.selectRow(defaultSecond, inComponent: 0, animated: false)
    }
    @IBAction func startButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showCountDownVC", sender: self)
    }
    
    let seconds = Array(0...60)
    let defaultSecond = 30
    var selectedValue: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickUpSecond.delegate = self
        pickUpSecond.dataSource = self
        
        // デフォルト値を30に設定
        selectedValue = defaultSecond
        if let selectedValue = selectedValue {
            pickUpSecond.selectRow(selectedValue, inComponent: 0, animated: false)
        }
    }
    
    // UIPickerViewの列数
    func numberOfComponents(in pickUpSecond: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return seconds.count
    }
    
    // UIPickerViewに表示するデータ
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(seconds[row])"
    }
    
    // 選択されたデータを渡す
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = seconds[row]
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCountDownVC" {
            if let destinationVC = segue.destination as? CountDownViewController {
                destinationVC.selectedValue = selectedValue
            }
        }
    }
}

