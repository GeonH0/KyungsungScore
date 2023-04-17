//
//  resultViewController.swift
//  KyungSungScore
//
//  Created by 김건호 on 2023/04/12.
//

import UIKit

class resultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    var result : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let result = result{
            self.resultLabel.text = result
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
