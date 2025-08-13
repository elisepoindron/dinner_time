import axios from "axios"

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
