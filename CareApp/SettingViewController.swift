//
//  SettingViewController.swift
//  CareApp
//
//  Created by 髙津悠樹 on 2022/04/22.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var dateText: UITextField!
    @IBOutlet weak var aofEText: UITextField!
    
    let list = ["1","2","3"]
    var toolBar: UIToolbar!
    var pickerView = UIPickerView()
    var date = "a"
    var option = "a"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerView()
        
        dateText.delegate = self
        weightText.keyboardType = UIKeyboardType.numberPad
        
        /* ここで保存処理を書いているけど画面遷移をした時にエラーが出る
        nameText.text = (UserDefaults.standard.object(forKey: "nameKey") as! String)
        weightText.text = (UserDefaults.standard.object(forKey: "weigtKey") as! String)
        dateText.text = (UserDefaults.standard.object(forKey: "dateKey") as! String)
        aofEText.text = (UserDefaults.standard.object(forKey: "exerKey") as! String)
         */

        // Do any additional setup after loading the view.
    }
    func setupToolbar() {
        toolBar = UIToolbar()
        toolBar.sizeToFit()
        let toolBarBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBtn))
        toolBar.items = [toolBarBtn]
        dateText.inputAccessoryView = toolBar
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.time
        textField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sendar:)), for: UIControl.Event.valueChanged)
    }
    @objc func datePickerValueChanged(sendar: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm"
        dateText.text = dateFormatter.string(from: sendar.date)
    }
    @objc func doneBtn() {
        dateText.resignFirstResponder()
    }
    func createPickerView() {
        pickerView.delegate = self
        aofEText.inputView = pickerView
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(SettingViewController.donePicker))
        toolbar.setItems([doneButtonItem], animated: true)
        aofEText.inputAccessoryView = toolbar
    }
    @objc func donePicker() {
        aofEText.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        aofEText.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        option = list[row]
    }

}
