import axios from "axios"

/**
 * Get all recipes matching the research filter on ingredients. 
 * 
 * @param {string} filter 
 * @returns a list of Recipe
 */
async function getRecipes(filter) {
  let recipes = []
  try {
    const response = await axios.get("/api/v1/recipes/", {
      params: { ingredients: filter },
    })
    recipes = response.data
  } catch (err) {
    console.log("Error", err)
  }

  return recipes
}

/**
 * Get a recipe by id, with its details
 * 
 * @param {BigInteger} id 
 * @returns a Recipe
 */
async function getRecipe(id) {
  let recipe
  try {
    const response = await axios.get(`/api/v1/recipes/${id}`)
    recipe = response.data
  } catch (err) {
    console.log("Error", err)
  }

  return recipe
}

export { getRecipes, getRecipe }
