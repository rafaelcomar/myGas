//
//  PostoTableViewCell.swift
//  MeuCombustivel
//
//  Created by alunor17 on 28/04/17.
//  Copyright © 2017 Comar Ltda. All rights reserved.
//

import UIKit

class PostoTableViewCell: UITableViewCell {

    @IBOutlet weak var nomePostoLabel: UILabel!
    @IBOutlet weak var precoLabel: UILabel!
    
    
    override func awakeFromNib() {    
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
