//
//  ScoreCell.swift
//  KyungSungScore
//
//  Created by 김건호 on 2023/06/13.
//

import UIKit

class ScoreCell: UICollectionViewCell {
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var schoolLabel: UILabel!
    
    @IBOutlet weak var satLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.contentView.layer.cornerRadius = 3.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    
    
}
