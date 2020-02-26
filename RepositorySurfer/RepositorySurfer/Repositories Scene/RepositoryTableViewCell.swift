//
//  RepositoryTableViewCell.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        starCountLabel.text = "★"
        nameLabel.text = nil
        languageLabel.text = "No language selected."
        descriptionLabel.text = nil
    }
    
    func setUI(with repository: Repository) {
        starCountLabel.text = "★ \(repository.starCount > 0 ? String(repository.starCount) : "")"
        nameLabel.text = repository.name
        languageLabel.text = "No language selected."
        descriptionLabel.text = repository.description
    }
}
