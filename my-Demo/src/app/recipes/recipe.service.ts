import { EventEmitter, Injectable } from '@angular/core';

import { Recipe } from './recipe.model';
import { Ingredient } from '../shared/ingredient.model';
import { ShoppingListService } from '../shopping-list/shopping-list.service';


@Injectable()
export class RecipeService{
    recipeSelected = new EventEmitter<Recipe>();
  private recipes: Recipe[] = [
        new Recipe(
        'A Test sandwich', 
        'This is simply a test', 
        'https://pinchofyum.com/wp-content/uploads/Chicken-Sandwich-Feature-1.jpg',
        [
            new Ingredient('Meat',500),
            new Ingredient('Tea',40),
        ]
        ),
        new Recipe(
        'Testing Burger val', 
        'testing simply',
         'https://www.seriouseats.com/recipes/images/2015/07/20150728-homemade-whopper-food-lab-35.jpg',
         [
            new Ingredient('Mike',500),
            new Ingredient('Roze',40),
        ]
        )
      ];
    constructor(private slService: ShoppingListService){}

      getRecipe(){
          return this.recipes.slice();
      }

      addIngredientToShoppingList(ingredients: Ingredient[]){
        this.slService.addIngredients(ingredients);
      }
}