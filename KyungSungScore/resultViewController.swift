//
//  ResultViewController.swift
//  KyungSungScore
//
//  Created by 김건호 on 2023/04/12.
//

import UIKit
import FirebaseDatabase

class resultViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    struct Score: Codable {
        let cnt: Int
        let schoolScore: Double
        let satScore: Double
        let interviewScore: Double
        let name: String
    }

    var ref: DatabaseReference! // Firebase Realtime Database
    var scoreList: [Score] = []
    var result: String?
    var majorIndex: Int?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        ref = Database.database().reference()

        ref.observe(.value){ snapshot in
            guard let value = snapshot.value as? [String: [String: Any]] else { return }
  
            var newScoreList: [Score] = []
            
            for (_, value) in value {
                if let cnt = value["cnt"] as? Int,
                    let schoolScore = value["schoolScore"] as? Double,
                    let satScore = value["satScore"] as? Double,
                    let interviewScore = value["interviewScore"] as? Double,
                    let name = value["name"] as? String {
      
                    let newScore = Score(cnt: cnt, schoolScore: schoolScore, satScore: satScore, interviewScore: interviewScore, name: name)
                    newScoreList.append(newScore)
                }
            }
            
            self.scoreList = newScoreList.sorted { $0.cnt > $1.cnt }


            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

        if let result = result {
            self.resultLabel.text = result
        }
    }

    private func configureCollectionView() {
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scoreList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScoreCell", for: indexPath) as? ScoreCell else {
            return UICollectionViewCell()
        }

        let score = scoreList[indexPath.row]
        cell.countLabel.text = "지원자수: \(score.cnt)명"
        cell.nameLabel.text = "학과: \(score.name)"
        cell.schoolLabel.text = String(format: "평균내신점수: %.2f점", score.schoolScore / Double(score.cnt))
        cell.satLabel.text = String(format: "평균수능점수: %.2f점", score.satScore / Double(score.cnt))


        return cell
    }
}
extension resultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2 // 화면 너비에서 30을 빼고 2로 나눠 셀의 폭을 구함
        let height = width // 셀의 높이는 폭과 동일하게 설정 (정사각형)

        return CGSize(width: width, height: height)
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // 세로 간격 설정
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // 가로 간격 설정
    }
}

