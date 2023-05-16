//
//  ViewController.swift
//  KyungSungScore
//
//  Created by 김건호 on 2023/03/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    
    
    var mayjor = University()

    @IBOutlet weak var score: UITextField!
    
    @IBOutlet weak var typeControl: UISegmentedControl!
    
    @IBOutlet weak var mayjorPickerView: UIPickerView!
    @IBOutlet weak var showMajor: UITextField!
    

    
    @IBOutlet weak var scoreButton: UIButton!
    
    
    
    var mscore : Double = 0.0
    var idx : Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mayjorPickerView.dataSource = self
        mayjorPickerView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return mayjor.mayjors.count
        } else {
            let selectedMayjor = mayjorPickerView.selectedRow(inComponent: 0)
            return mayjor.mayjors[selectedMayjor].mayjor.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return mayjor.mayjors[row].college
        } else {
            let selectedmayjor = mayjorPickerView.selectedRow(inComponent: 0)
            return mayjor.mayjors[selectedmayjor].mayjor[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            mayjorPickerView.selectRow(0,inComponent: 1,animated: false)
        }
        
        let collegeIdx = mayjorPickerView.selectedRow(inComponent: 0)
        let selectedColleage = mayjor.mayjors[collegeIdx].college
        let mayjorIdx = mayjorPickerView.selectedRow(inComponent: 1)
        let selectedMayjor = mayjor.mayjors[collegeIdx].mayjor[mayjorIdx]        
        
        if self.typeControl.selectedSegmentIndex == 0{
            mscore =  mayjor.mayjors[collegeIdx].schoolScore[mayjorIdx]
            idx = collegeIdx+mayjorIdx
            
        }
        else{
            mscore = mayjor.mayjors[collegeIdx].satScore[mayjorIdx]
            idx = collegeIdx+mayjorIdx
            
        }
        
        
//        self.resultLabel.sizeToFit()
//        resultLabel.text = "\(selectedColleage),\(selectedMayjor)"
        
        mayjorPickerView.reloadComponent(1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? resultViewController{
            
            let sc = Double(self.score.text!)
            if sc! < mscore {
                viewController.result = "합격입니다\(idx)"
                
            }
            else{
                viewController.result = "불합격입니다.\(idx)"
            }
            
        }
            
    }
    
    
    @IBAction func tapScoreButton(_ sender: UIButton) {
        
        
        
    }
    
    
}

