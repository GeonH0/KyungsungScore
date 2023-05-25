//
//  resultViewController.swift
//  KyungSungScore
//
//  Created by 김건호 on 2023/04/12.
//

import UIKit
import FirebaseDatabase


class resultViewController: UIViewController {
    
    var ref : DatabaseReference! //firebase realtime database
    
    var mayjorscoreList : [ScoreList] = []

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var result : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureCollectionView()
        
        
        if let result = result {
            self.resultLabel.text = result
        }
        
        ref = Database.database().reference()
        
        ref.observe(.value) { [weak self] snapshot in
            guard let value = snapshot.value as? [String:[String:Any]] else {return}
            
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let scoreData = try JSONDecoder().decode([String:ScoreList].self, from: jsonData)
                let scoreList = Array(scoreData.values)
//                self?.mayjorscoreList = scoreList.sorted{$0.count < $1.count} // 지원자가 많은 수로 정리
                
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                
            } catch let error {
                print("ERROR JSON parsing\(error.localizedDescription)")
            }
        }
    }
    
    private func configureCollectionView(){
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.dataSource = self
    }
    
}

extension resultViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mayjorscoreList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //표시할 셀 요청
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScoreCell", for: indexPath) as? ScoreCell else {return UICollectionViewCell()}
        
        cell.nameLabel.text = mayjorscoreList[indexPath.row].name
        print(mayjorscoreList[indexPath.row].name)
        cell.satscoreLabel.text = mayjorscoreList[indexPath.row].satScore
        return cell
    }
    
        
}

extension ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2)-20, height: 200)
    }
}






