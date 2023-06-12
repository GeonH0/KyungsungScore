//
//  resultViewController.swift
//  KyungSungScore
//
//  Created by 김건호 on 2023/04/12.
//

import UIKit
import Firebase
import FirebaseDatabase

class resultViewController: UIViewController {
    
    var ref: DatabaseReference! //firebase realtime database
    
    var mayjorscoreList: [Score] = []

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var result: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        // Setting up the test data    

        if let result = result {
            self.resultLabel.text = result
        }
        
        // Realtime Database observer



    }
}


