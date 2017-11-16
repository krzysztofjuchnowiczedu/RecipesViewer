//
//  APIService.swift
//  Recipe Viewer
//
//  Created by Krzysztof Juchnowicz on 16.11.2017.
//  Copyright © 2017 Krzysztof Juchnowicz. All rights reserved.
//
import Alamofire
import Foundation
import SwiftyJSON

class APIService {
    
    static let instance  = APIService()
    
    func getRecipes(query: String, completion: @escaping(([Recipe])->())){
        let requestURL = "\(Constants.API_URL)?q=\(query)"
        Alamofire.request(requestURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { response in
            if response.result.error == nil {
                guard let data = response.data else{ return }
                let json = JSON(data: data)
                guard let jsonRecipes = json["results"].array else { return }
                var recipes = [Recipe]()
                for jsonRecipe in jsonRecipes{
                    let title = jsonRecipe["title"].stringValue
                    let url = jsonRecipe["href"].stringValue
                    let ingredients = jsonRecipe["ingredients"].stringValue
                    let imageURL = jsonRecipe["thumbnail"].stringValue
                    let recipe = Recipe(title: title, url: url, ingredients: ingredients, imageURL: imageURL)
                    recipes.append(recipe)
                }
                completion(recipes)
            }
        })
    }
}
