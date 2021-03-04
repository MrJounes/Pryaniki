//
//  TextCell.swift
//  PryanikyTest
//
//  Created by Игорь Дикань on 04.03.2021.
//

import UIKit

class TextCell: UITableViewCell {
    
    static let nibName = "TextCell"
    static let reuseId = nibName
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Internal vars
    private var data: TextBlockModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - Public methods
extension TextCell {
    
    func setupCell(with data: TextBlockModel) {
        self.data = data
        titleLabel.text = data.text
    }
}
