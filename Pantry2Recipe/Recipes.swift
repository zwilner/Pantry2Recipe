//
//  Recipes.swift
//  Pantry2Recipe
//
//  Created by Zach Wilner on 11/28/17.
//  Copyright © 2017 Zach Wilner. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Recipes {
    
    struct RecipeData {
        var title: String
        var URL: String
        var ingredients: String
        var imageURL: String
        var image: UIImage
    }
    var moreResults = true
    var data: Data!
    
    var recipeArray = [RecipeData]()
    var recipeURL = "http://www.recipepuppy.com/api/"
    var numberOfResults = 0
    var noImageURL = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png"
    
    func getRecipes(ingr1: String, ingr2: String, ingr3: String, ingr4: String, ingr5: String, pageNum: Int, completed: @escaping () -> ()) {
        recipeURL = recipeURL + "?i=\(ingr1),\(ingr2),\(ingr3),\(ingr4),\(ingr5),\(ingr1)s,\(ingr2)s,\(ingr3)s,\(ingr4)s,\(ingr5)s&p=\(pageNum)"
        Alamofire.request(recipeURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.numberOfResults = json["results"].count
                if self.numberOfResults != 0{
                    for index in 0...self.numberOfResults-1{
                        var title = json["results"][index]["title"].stringValue
                        let url = json["results"][index]["href"].stringValue
                        let ingredients = json["results"][index]["ingredients"].stringValue
                        var imageURL = json["results"][index]["thumbnail"].stringValue
                        if imageURL == "" {
                            imageURL = self.noImageURL
                        }
                        guard let x = URL(string: imageURL) else { return }
                        do {
                            self.data = try Data(contentsOf: x)
                            
                        } catch {
                            print("ERROR: error thrown trying to get image from URL \(x)")

                        }
                        
                        title = title.trimmingCharacters(in: .whitespacesAndNewlines)
                        self.recipeArray.append(RecipeData(title: title, URL: url, ingredients: ingredients, imageURL: imageURL, image: UIImage(data: self.data)!))
                        print("**********\(self.recipeArray[index].title)")
                    }
                }
            case .failure(let error):
                print("ERROR: \(error) failed to get data from url")
                self.moreResults = false
            }
            completed()
        }
        
    }
    
}
