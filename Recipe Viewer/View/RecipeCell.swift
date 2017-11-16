//
//  RecipeCell.swift
//  Recipe Viewer
//
//  Created by Krzysztof Juchnowicz on 16.11.2017.
//  Copyright © 2017 Krzysztof Juchnowicz. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class RecipeCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingridientsLabel: UILabel!
    @IBOutlet weak var recipeURLLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func resetContent(){
        titleLabel.text = ""
        ingridientsLabel.text = ""
        recipeURLLabel.text = ""
        recipeImage.image = UIImage(named: "no-image")
    }
    
    func setRecipe(recipe: Recipe){
        titleLabel.text = recipe.title
        ingridientsLabel.text = recipe.ingredients
        recipeURLLabel.text = recipe.url
        recipeImage.image = UIImage(named: "no-image")
        if let imageURL = URL(string: recipe.imageURL){
            recipeImage.af_setImage(withURL: imageURL)
        }
    }
}
