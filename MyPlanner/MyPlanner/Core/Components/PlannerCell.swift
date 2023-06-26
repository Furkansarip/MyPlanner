//
//  PlannerCell.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 24.06.2023.
//

import UIKit

class PlannerCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    let identifier = "PlannerCellIdentifier"
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureReminderCell(reminderModel: Reminders) {
        titleLabel.text = reminderModel.rTitle
        dateLabel.text = reminderModel.rDate
        descriptionLabel.text = reminderModel.rDescription
        
    }
    
    func configureGoalCell(goalModel: Goals) {
        titleLabel.text = goalModel.gTitle
        dateLabel.text = goalModel.gType
        descriptionLabel.text = goalModel.gDescription
        let data:BaseEnum = BaseEnum(rawValue: goalModel.gType ?? "") ?? BaseEnum.other
        switch data {
        case .money:
            cellImage.backgroundColor = .red
        case .health:
            cellImage.backgroundColor = .blue
        case .life:
            cellImage.backgroundColor = .systemPink
        case .personal:
            cellImage.backgroundColor = .purple
        case .passion:
            cellImage.backgroundColor = .green
        case .other:
            cellImage.backgroundColor = .cyan
        }
        
        
    }
}
