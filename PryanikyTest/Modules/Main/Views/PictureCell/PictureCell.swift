//
//  PictureCell.swift
//  PryanikyTest
//
//  Created by Игорь Дикань on 04.03.2021.
//

import UIKit
import Kingfisher

class PictureCell: UITableViewCell {
    
    static let nibName = "PictureCell"
    static let reuseId = nibName
    
    // MARK: - IBOutlets
    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - Public methods
extension PictureCell {
    
    func setupCell(with data: PictureBlockModel) {
        cellImageView.kf.setImage(with: URL(string: data.urlString))
    }
}
