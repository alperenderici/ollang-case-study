<a name="readme-top"></a>
<br />
<div align="center">

<h3 align="center">Recipe App - Ollang Case Study</h3>



## About The Project

This mobile app project was developed as the case study of Ollang. The project aims to made by bloc-cubit state managament. 
The main objective is complete requirements and after that complete bonus requirements: 
 
### **Requirements**
+ The app should have a home screen that allows users to search for recipes.
+ Users should be able to search for recipes based on ingredients or recipe names.
+ The app should display a list of recipes that match the user's search query.
+ Users should be able to view the details of a recipe by tapping on it in the list.
+ The recipe details screen should display the recipe name, ingredients, and instructions(`ingredientLines`).
- Users should be able to save recipes to their favorites list by tapping a "favorite" button on the recipe details screen.
- The app should have a favorites screen that displays a list of the user's saved recipes.
- Users should be able to remove recipes from their favorites list by swiping left on the recipe in the favorites list.
 More than, providing a user-friendly and intuitive interface is also important
 
 ## **Bonus Requirements**

+ Implement a "random recipe" feature that allows users to find a random recipe.
- Users can filter search results by dietary requirements such as vegan, gluten-free, etc.
- Implement a search history feature that allows users to see their previous search queries.
- Implement a recipe-sharing feature that allows users to share a recipe with their friends via email or social media.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
 
 
## Demo

https://www.veed.io/view/9007fd7b-9322-4dae-8fab-eff77c213d18?sharingWidget=true&panel=share

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Details and Use
 I prefer to use Flutter Bloc - Cubit State management.
 For storage of favorite recipes, I tried to use sqlite, after that I change to learn and use with Hive.
 
 For the useage it is enough to run flutter pub get after on recipe_app directory terminal. (Works with recent Flutter version)

### **Technical Requirements**

- Use the **[Edamam Recipe Search API](https://developer.edamam.com/edamam-docs-recipe-api)** to search for recipes and retrieve recipe details.
- Use Flutter and Dart to build the app.
- Use a state management solution such as **[Provider](https://pub.dev/packages/provider)** or **[GetX](https://pub.dev/packages/get)** or **[Bloc](https://pub.dev/packages/bloc)** to manage the app's state.
- Use a navigation solution such as **[Flutter Navigation](https://flutter.dev/docs/development/ui/navigation)** and **Flutter Navigator 2.0** to navigate between screens.
- Use a database solution such as **[Hive](https://pub.dev/packages/hive)** or **[SQLite](https://pub.dev/packages/sqflite)** to store the user's favorites list.


## Features

|<img name='list-recipes-initially' src="https://github.com/alperenderici/ollang-case-study/blob/main/Screenshots/ss1.png" width="200" height="300" />| <img name='list-random-recipes-by-button' src="https://github.com/alperenderici/ollang-case-study/blob/main/Screenshots/ss3.png" width="200" height="300" /> | <img src="https://github.com/alperenderici/ollang-case-study/blob/main/Screenshots/ss4.png" width="200" height="300" /> | <img name='search-and-list-recipes' src="https://github.com/alperenderici/ollang-case-study/blob/main/Screenshots/ss5.png" width="200" height="300" /> | <img name='ingredients' src="https://github.com/alperenderici/ollang-case-study/blob/main/Screenshots/ss6.png" width="200" height="300" /> | <img name='ingredients-lines' src="https://github.com/alperenderici/ollang-case-study/blob/main/Screenshots/ss7.png" width="200" height="300" /> |
|:--:|:--:|:--:|:--:|:--:|:--:|
