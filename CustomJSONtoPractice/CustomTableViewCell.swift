//
//  CustomTableViewCell.swift
//  CustomJSONtoPractice
//
//  Created by EthanLin on 2018/1/8.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

protocol TableViewCellButtonTapped{
    func buttonBeTapped(index: IndexPath)
}

class CustomTableViewCell: UITableViewCell {
    
    
    var delegate:TableViewCellButtonTapped?
    
    //這個index用來存成tableView的indexPath
    var index:IndexPath?
        
    @IBAction func didTapButton(_ sender: UIButton) {
        delegate?.buttonBeTapped(index: index!)
    }
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    
    @IBOutlet weak var cellLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
