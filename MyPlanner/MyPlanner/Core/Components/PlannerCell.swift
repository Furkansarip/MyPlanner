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
    
    override func prepareForReuse() {
        cellImage.image = nil
    }
    
    func configureGoalCell(goalModel: Goals) {
        titleLabel.text = goalModel.gTitle
        dateLabel.text = goalModel.gDate
        descriptionLabel.text = goalModel.gDescription
        cellImage.layer.borderWidth = 1
        
        let data:BaseEnum = BaseEnum(rawValue: goalModel.gType ?? "") ?? BaseEnum.other
        switch data {
        case .money:
            cellImage.image = UIImage(named: "money.jpg")
        case .health:
            cellImage.image = UIImage(systemName: "heart.fill")
        case .life:
            cellImage.image = UIImage(systemName: "house.fill")
        case .personal:
            cellImage.image = UIImage(named: "gym.jpg")
        case .passion:
            cellImage.image = UIImage(named: "passion.jpg")
        case .other:
            cellImage.backgroundColor = .cyan
        }
    }
    
    func configureReminderCell(reminderModel: Reminders) {
        titleLabel.text = reminderModel.rTitle
        dateLabel.text = reminderModel.rDate
        descriptionLabel.text = reminderModel.rDescription
        cellImage.layer.borderWidth = 1
        let data:BaseEnum = BaseEnum(rawValue: reminderModel.rType ?? "") ?? BaseEnum.other
        switch data {
        case .money:
            cellImage.image = UIImage(named: "money.jpg")
        case .health:
            cellImage.image = UIImage(systemName: "heart.fill")
        case .life:
            cellImage.image = UIImage(systemName: "house.fill")
        case .personal:
            cellImage.image = UIImage(named: "gym.jpg")
        case .passion:
            cellImage.image = UIImage(named: "passion.jpg")
        case .other:
            cellImage.backgroundColor = .cyan
        }
    }
}
