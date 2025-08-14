<template>
  <v-container class="d-flex flex-column justify-center text-center">
    <h1>Recipes</h1>
    <v-row class="py-14">
      <v-col cols="10">
        <v-text-field
          v-model="ingredients_filter"
          label="Filter by ingredients"
        ></v-text-field>
      </v-col>
      <v-col>
        <v-btn @click="refreshRecipes(ingredients_filter)"> Search </v-btn>
      </v-col>
    </v-row>
    <v-data-table :items="recipes" @click:row="openRecipe"></v-data-table>
    <v-dialog v-model="recipe_dialog">
      <v-card :title="selected_recipe.name">
        <v-row class="pa-5">
          <v-col cols="12">
            <p>Rating: {{ selected_recipe.rating }}</p>
            <p>Cooking Time: {{ selected_recipe.cooking_time }}</p>
            <p>Preparation Time: {{ selected_recipe.preparation_time }}</p>
            <p>Cuisine: {{ selected_recipe.cuisine }}</p>
            <p>Category: {{ selected_recipe.category }}</p>
            <p>Ingredients:</p>
            <p
              class="pl-4"
              v-for="ingredient in selected_recipe.ingredients"
              :key="ingredient.id"
            >
              {{ ingredient.name }}
            </p>
          </v-col>
        </v-row>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import { defineComponent, ref, onMounted } from "vue";
import { getRecipes, getRecipe } from "../helpers/recipes_helper";

export default defineComponent({
  setup() {
    const recipes = ref([]);
    const ingredients_filter = ref("");
    const recipe_dialog = ref(false);
    const selected_recipe = ref(null);

    /**
     * Get a list of recipes filtered on ingredients
     * 
     * @param filter a string of ingredients to be filtered on
     */
    async function refreshRecipes(filter) {
      recipes.value = await getRecipes(filter);
    }

    /**
     * Get the selected recipe's details and open the a dialog to display them
     * 
     * @param _ 
     * @param row the selected row
     */
    async function openRecipe(_, row) {
      selected_recipe.value = await getRecipe(row.item.id);
      recipe_dialog.value = true;
    }

    onMounted(async () => {
      await refreshRecipes(ingredients_filter.value);
    });

    return {
      recipes,
      ingredients_filter,
      refreshRecipes,
      openRecipe,
      recipe_dialog,
      selected_recipe,
    };
  },
});
</script>