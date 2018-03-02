//
//  PassTableViewCell.swift
//  ISSPasses
//
//  Created by Andrei Daniyalian on 2/20/18.
//  Copyright © 2018 Andrei Daniyalian. All rights reserved.
//

import UIKit

class PassTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with pass: PassObject) {
        let startDate = Date(timeIntervalSince1970: pass.risetime)
        let endDate = Date(timeIntervalSince1970: pass.risetime + pass.duration)
        let startDateString = BusinessLayerManager.shared.dateFormatter.string(from: startDate)
        let endDateString = BusinessLayerManager.shared.dateFormatter.string(from: endDate)
        
        titleLabel.text = "\(startDateString) - \(endDateString)"
        subtitleLabel.text = "Duration: \(pass.duration)"
    }

}
