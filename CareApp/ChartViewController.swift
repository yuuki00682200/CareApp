//
//  ViewController.swift
//  Payment
//
//  Created by 悠樹高津 on 2019/11/14.
//  Copyright © 2019 悠樹高津. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pieChartsView:  PieChartView!
    @IBOutlet weak var textField: UITextField!
    let saveData: UserDefaults = UserDefaults.standard
    @IBAction func saveButton(){
        let num = (pickerView?.selectedRow(inComponent: 0))!
        payNum[num] = payNum[num] + Double(textField.text!)!
        date[num] = PieChartDataEntry(value: payNum[num], label: list[num])
        let payData = ["pay":list[num],"sum":textField.text!] as [String : String]
        addData(newData: payData)

    }
    
    func addData(newData: [String : String]) {
        var history = [[String : String]]()
        if saveData.object(forKey: "histry") != nil {
            history = saveData.object(forKey: "histry") as! [[String : String]]
        }
        
        history.insert(newData, at: 0)
        saveData.set(history, forKey: "histry")

    }
    
    @IBOutlet var pickerView: UIPickerView? = UIPickerView()
    let list: [String] = ["運動1","運動2","運動3"]
    var payNum: [Double] = [0,0,0]
    var date = [PieChartDataEntry]() {
        didSet {
            let dateset = PieChartDataSet(entries: date, label: "")
            dateset.colors = ChartColorTemplates.vordiplom()
            dateset.valueLineColor = UIColor.black
            dateset.entryLabelColor = UIColor.black
            self.pieChartsView.data = PieChartData(dataSet: dateset)
        }
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
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //aveData.set(num, forKey: "")
        pickerView?.delegate = self
        pickerView?.dataSource = self
        //pickerView.showsSelectionIndicator = true
        
        self.pieChartsView.centerText = "合計"
        
        self.textField.keyboardType = UIKeyboardType.numberPad
        pieChartsView.isUserInteractionEnabled = false
        
       date = [
        PieChartDataEntry(value: 0, label: "運動1"),
        PieChartDataEntry(value: 0, label: "運動2"),
        PieChartDataEntry(value: 0, label: "運動3")
        ]
       
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.maximumFractionDigits = 2
        formatter.multiplier = 1.0
        self.pieChartsView.data?.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        self.pieChartsView.usePercentValuesEnabled = false
        
        view.addSubview(self.pieChartsView)
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        toolBar.barStyle = UIBarStyle.default
        toolBar.sizeToFit()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.done))
        toolBar.items = [spacer, commitButton]
        textField.inputAccessoryView = toolBar
        
    }
    @objc func done() {
           textField.endEditing(true)
        //textField.text = "\(list[pickerView.selectedRow(inComponent: 0)])"
        
    }
    
}
