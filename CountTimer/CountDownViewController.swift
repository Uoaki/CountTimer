//
//  CountDownViewController.swift
//  CountTimer
//
//  Created by 파루파루상 on 2024/09/07.
//

import UIKit

class CountDownViewController: UIViewController {
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var controlButton: UIButton!
    
    var selectedValue: Int?
    var countDownTimer: Timer?
    var isCountingDown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let countDownValue = selectedValue else {
            valueLabel.text = "Error"
            return
        }
        
        valueLabel.text = "\(countDownValue)"
        controlButton.setTitle("Stop", for: .normal)
        startCountdown()
    }
    
    func startCountdown() {
        if countDownTimer == nil {
            countDownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
        }
        isCountingDown = true
    }
    
    func stopCountDown() {
        countDownTimer?.invalidate()
        countDownTimer = nil
        isCountingDown = false
    }
    
    @IBAction func controlButtonTapped(_ sender: UIButton) {
        if isCountingDown {
            stopCountDown()
            controlButton.setTitle("Resume", for: .normal)
        } else {
            startCountdown()
            controlButton.setTitle("Stop", for: .normal)
        }
    }
    
    @objc func updateCountdown() {
        guard let currentValue = selectedValue, currentValue > 0 else {
            stopCountDown()
            valueLabel.text = "0"
            
            NotificationManager.shared.scheduleNotification(title: "カウントダウン終了", body: "カウントダウンが終了しました。")
            
            // 前のビューに戻る
            navigationController?.popViewController(animated: true)
            return
        }
        
        selectedValue = currentValue - 1
        valueLabel.text = "\(selectedValue!)"
        
        if selectedValue! < 10 {
            view.backgroundColor = .red
        }
    
    }
    
    // 画面が消える際にカウントダウンを無効にする
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopCountDown()
    }
}
