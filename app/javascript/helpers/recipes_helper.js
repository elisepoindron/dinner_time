import axios from "axios"

async function getRecipes() {
  let recipes = []
  try {
    const response = await axios.get("/api/recipes")
    recipes = response.data
  } catch (err) {
    console.log("Error", err)
  }

  return recipes
}

export {getRecipes}