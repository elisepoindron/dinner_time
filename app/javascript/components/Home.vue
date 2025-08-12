<template>
  <v-container class="d-flex flex-column justify-center text-center">
    <h1>Recipes</h1>
    <v-data-table :items="recipes"></v-data-table>

  </v-container>
</template>

<script>
import { defineComponent, ref, onMounted } from "vue";
import { getRecipes } from "../helpers/recipes_helper";

export default defineComponent({
  setup() {
    const recipes = ref([]);

    // Methods

    async function refreshRecipes() {
      recipes.value = await getRecipes();
      // console.log("refreshed");
    }

    // Script

    onMounted(async () => {
      await refreshRecipes();
    });

    return {
      recipes,
    };
  },
});
</script>