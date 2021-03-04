//
//  SelectorCell.swift
//  PryanikyTest
//
//  Created by Игорь Дикань on 04.03.2021.
//

import UIKit

class SelectorCell: UITableViewCell {
    
    static let nibName = "SelectorCell"
    static let reuseId = nibName
    
    // MARK: - IBOutlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - Internal vars
    private var data: SelectorBlockModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - IBActions
    @IBAction func didTapSegment(_ sender: UISegmentedControl) {
        guard let variant = data?.variants[sender.selectedSegmentIndex] else {
            return
        }
        print("Id: \(variant.id) - text: \(variant.text)")
    }
}

// MARK: - Public methods
extension SelectorCell {
    
    func setupCell(with data: SelectorBlockModel) {
        self.data = data
        let variants = data.variants
        if segmentedControl.numberOfSegments != variants.count {
            segmentedControl.removeAllSegments()
            let _ = variants.enumerated().map { (index, variant) in
                segmentedControl.insertSegment(withTitle: variant.text, at: index, animated: false)
            }
        } else {
            let _ = variants.enumerated().map { (index, variant) in
                segmentedControl.setTitle(variants[index].text, forSegmentAt: index)
            }
        }
        let _ = variants.enumerated().map { (index, variant) in
            if data.selectedId == variant.id {
                segmentedControl.selectedSegmentIndex = index
            } else {
                segmentedControl.selectedSegmentIndex = 0
            }
        }
    }
}
