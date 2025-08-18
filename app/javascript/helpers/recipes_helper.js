import axios from "axios"

/**
 * Get all recipes matching the research filter on ingredients.
 *
 * @param {string} filter
 * @returns a list of Recipe
 */
async function getRecipes(ingredientFilter, page, itemsPerPage, sortBy) {
  let recipes = []
  let parsedSortBy = {}
  let total_count = null

  for (const sortField of sortBy) {
    parsedSortBy[sortField.key] = sortField.order
  }
  try {
    const response = await axios.get("/api/v1/recipes/", {
      params: {
        ingredients: ingredientFilter,
        page: page,
        items_per_page: itemsPerPage,
        sort_by: parsedSortBy,
      },
    })
    recipes = response.data.data
    total_count = response.data.total_count
  } catch (err) {
    console.log("Error", err)
  }

  return [recipes, total_count]
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
