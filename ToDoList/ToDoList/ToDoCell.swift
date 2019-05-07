//
//  ToDoCell.swift
//  ToDoList
//
//  Created by MacAir11 on 04/25/19.
//  Copyright © 2019 CCC iOS Boot Camp. All rights reserved.
//

import UIKit;

protocol ToDoCellDelegate: class {   //p. 765
    func checkmarkTapped(sender: ToDoCell);
}

class ToDoCell: UITableViewCell {   //p. 761
    var delegate: ToDoCellDelegate? = nil;   //p. 765

    @IBOutlet weak var isCompleteButton: UIButton!;   //p. 764
    @IBOutlet weak var titleLabel: UILabel!;
    
    override func awakeFromNib() {
        super.awakeFromNib();
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);

        // Configure the view for the selected state.
    }
    
    @IBAction func completeButtonTapped(_ sender: UIButton) {   //pp. 765-766
        delegate?.checkmarkTapped(sender: self);
    }
}
