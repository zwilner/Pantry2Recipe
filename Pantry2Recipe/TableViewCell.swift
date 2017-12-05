//
//  TableViewCell.swift
//  Pantry2Recipe
//
//  Created by Zach Wilner on 11/30/17.
//  Copyright © 2017 Zach Wilner. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var recipeCellImage: UIImageView!
    @IBOutlet weak var recipeCellTitle: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with recipe: Recipes.RecipeData){
        recipeCellImage.image = recipe.image
        recipeCellTitle.text = recipe.title
    }

}
