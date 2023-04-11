//
//  CountrylistTVC.swift
//  TayseerCompanyProject
//
//  Created by mohammed aqhil ahmed  on 10/04/23.
//

import UIKit

class CountrylistTVC: UITableViewCell {

    @IBOutlet weak var cellBgView: UIView!
    
    @IBOutlet weak var countryImgView: UIImageView!
    
    @IBOutlet weak var countryNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
