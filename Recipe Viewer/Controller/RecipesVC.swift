//
//  ViewController.swift
//  Recipe Viewer
//
//  Created by Krzysztof Juchnowicz on 16.11.2017.
//  Copyright © 2017 Krzysztof Juchnowicz. All rights reserved.
//

import UIKit

class RecipesVC: UIViewController {
    
    var recipes = [Recipe]()
    
    @IBOutlet weak var queryTextField: UITextField!
    @IBOutlet weak var recipesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.delegate = self
        recipesTableView.dataSource = self
    }
    
    private func updateRecipesTable(){
        recipesTableView.reloadData()
    }
    
    private func showRecipeDetail(recipe: Recipe){
        performSegue(withIdentifier: Constants.showRecipeDetailSegueIdentifier, sender: recipe)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showRecipeDetailSegueIdentifier{
            guard let recipe = sender as? Recipe else { return }
            guard let reciepeDetailVC = segue.destination as? RecipeDetailVC else { return }
            reciepeDetailVC.recipe = recipe
        }
    }
    
    @IBAction func queryHasChanged(_ sender: UITextField) {
        guard let query = sender.text else { return}
        if(query.isEmpty){
            clearTable()
        } else {
            APIService.instance.getRecipes(query: query, completion: {[weak self] recipes in
                self?.recipes = recipes
                self?.updateRecipesTable()
            })
        }
    }
    
    @IBAction func clearQueryPressed(_ sender: Any) {
        queryTextField.text = ""
        clearTable()
    }
}

extension RecipesVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = recipesTableView.dequeueReusableCell(withIdentifier: Constants.recipeCellidentifier) as? RecipeCell else { return UITableViewCell()}
        cell.resetContent()
        cell.setRecipe(recipe: recipes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showRecipeDetail(recipe: recipes[indexPath.row])
    }
    
    func clearTable(){
        recipes = [Recipe]()
        recipesTableView.reloadData()
    }
}

