//
//  RecipeDetailVC.swift
//  Recipe Viewer
//
//  Created by Krzysztof Juchnowicz on 16.11.2017.
//  Copyright © 2017 Krzysztof Juchnowicz. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class RecipeDetailVC: UIViewController {

    var recipe: Recipe?
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeIngridients: UILabel!
    @IBOutlet weak var recipeWebReference: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func initViews(){
        recipeTitle.text = recipe?.title ?? ""
        recipeIngridients.text = recipe?.ingredients ?? ""
        if let imageURL = URL(string: recipe?.imageURL ?? ""){
            recipeImage.af_setImage(withURL: imageURL)
        }
        let recipeWebReferenceText = recipe?.url ?? ""
        recipeWebReference.attributedText = NSMutableAttributedString(string: recipeWebReferenceText, attributes:[NSAttributedStringKey.link: URL(string: recipeWebReferenceText)!])
    }

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
