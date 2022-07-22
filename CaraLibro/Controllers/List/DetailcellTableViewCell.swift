//
//  DetailcellTableViewCell.swift
//  CaraLibro
//
//  Created by Ronald Publicidad on 21/07/22.
//
import UIKit

class DetailcellTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellTextView: UITextView!
    @IBOutlet weak var Age: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
