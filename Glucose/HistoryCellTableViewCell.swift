//
//  HistoryCellTableViewCell.swift
//  Glucose
//
//  Created by Nicolas Trafenchuk on 29.11.2020.
//

import UIKit
import CoreData

class HistoryCellTableViewCell: UITableViewCell {

    @IBOutlet weak var measure: UILabel!
    @IBOutlet weak var meal: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(history: HistoryModel) {
        measure.text = "\(history.measure ?? "") mg/dl"
        meal.text = history.meal
        date.text = history.date
    }

}
