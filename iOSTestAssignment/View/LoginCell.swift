//
//  LoginCell.swift
//  iOSTestAssignment
//
//  Created by Naveed ur Rehman on 25/06/2022.
//

import UIKit
import SDWebImage

class LoginCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var typLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(model: Item) {
        img.sd_setImage(with: URL(string: model.avatarUrl ?? ""), placeholderImage: UIImage(named: "placeholder"))
        loginLbl.text = model.login
        typLbl.text = model.type
    }

}
