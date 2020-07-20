//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by calum boustead on 12/07/2020.
//  Copyright © 2020 Boustead. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
