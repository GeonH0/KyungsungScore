//
//  ViewController.swift
//  KyungSungScore
//
//  Created by 김건호 on 2023/03/22.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    var ref : DatabaseReference! //firebase realtime database
    
    var scoreList : [Score] = []
    
    

    
    
    
    var mayjor = University()

    @IBOutlet weak var score: UITextField!
    
    @IBOutlet weak var typeControl: UISegmentedControl!
    
    @IBOutlet weak var mayjorPickerView: UIPickerView!
//    @IBOutlet weak var showMajor: UITextField!
    

    
    @IBOutlet weak var scoreButton: UIButton!
    
    
    
    var mscore : Double = 0.0
    var idx : Int = 0
    var sc : Double = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mayjorPickerView.dataSource = self
        mayjorPickerView.delegate = self
        
        ref = Database.database().reference()
        
        ref.observe(.value) { snapshot in
            guard let value = snapshot.value as? [String:Any] else { return}
            
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let scoreData = try JSONDecoder().decode([String:Score].self, from: jsonData)
                let sList = Array(scoreData.values)
                self.scoreList = sList
                
                print(sList)
            } catch let error {
                print("Error Json parsing\(error.localizedDescription)")
            }
        }
  
        

        
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
            if collegeIdx == 1{
                idx = 8+mayjorIdx
            }
            if collegeIdx == 2{
                idx = 13+mayjorIdx
            }
            if collegeIdx == 3{
                idx = 20+mayjorIdx
            }
            if collegeIdx == 4{
                idx = 35+mayjorIdx
            }
            if collegeIdx == 5{
                idx = 36+mayjorIdx
            }
            if collegeIdx == 6{
                idx = 50+mayjorIdx
            }
            if collegeIdx == 7{
                idx = 57+mayjorIdx
            }
            if collegeIdx == 0{
                idx = mayjorIdx
            }
                
            
            
        }
        else{
            mscore = mayjor.mayjors[collegeIdx].satScore[mayjorIdx]
            idx = collegeIdx+mayjorIdx
            
        }
        
        
//        self.resultLabel.sizeToFit()
//        resultLabel.text = "\(selectedColleage),\(selectedMayjor)"
        
        mayjorPickerView.reloadComponent(1)
    }
    private func showalert(){
        let alert = UIAlertController(title: "경고", message: "점수를 입력해 주세요", preferredStyle: UIAlertController.Style.alert)
        let OkAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default){
            action in self.dismiss(animated: true,completion: nil)
        }
        
        
        
        alert.addAction(OkAction)
        
        self.present(alert,animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? resultViewController {
            if let scoreText = self.score.text, let scoreValue = Double(scoreText) {
                self.sc = scoreValue
                
                if sc < mscore {
                    viewController.result = "합격입니다 \(idx)"
                } else {
                    viewController.result = "불합격입니다. \(idx)"
                }
                
                ref.child("mayjor\(idx+1)/count").setValue(ServerValue.increment(1))
                
                if self.typeControl.selectedSegmentIndex == 0 {
                    ref.child("mayjor\(idx+1)/schoolScore").setValue(ServerValue.increment(sc as NSNumber))
                } else {
                    ref.child("mayjor\(idx+1)/satScore").setValue(ServerValue.increment(sc as NSNumber))
                }
            } else {
                self.showalert()
            }
        }
    }


    
    
    @IBAction func tapScoreButton(_ sender: UIButton) {


        
    
        
        

                               
        
        
    }
    
    
}

