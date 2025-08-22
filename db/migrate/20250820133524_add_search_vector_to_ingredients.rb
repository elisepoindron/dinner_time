class AddSearchVectorToIngredients < ActiveRecord::Migration[7.2]
  def up
    add_column :ingredients, :search_vector, :tsvector
    add_index :ingredients, :search_vector, using: :gin

    # Initialiser la colonne
    execute <<-SQL
      UPDATE ingredients
      SET search_vector = to_tsvector('simple', coalesce(name, ''));
    SQL

    # Trigger pour mise à jour auto
    execute <<-SQL
      CREATE FUNCTION ingredients_search_vector_update() RETURNS trigger AS $$
      BEGIN
        NEW.search_vector :=
          to_tsvector('simple', coalesce(NEW.name, ''));
        RETURN NEW;
      END
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON ingredients FOR EACH ROW EXECUTE FUNCTION ingredients_search_vector_update();
    SQL
  end

  def down
    execute "DROP TRIGGER IF EXISTS tsvectorupdate ON ingredients;"
    execute "DROP FUNCTION IF EXISTS ingredients_search_vector_update();"
    remove_index :ingredients, :search_vector
    remove_column :ingredients, :search_vector
  end
end
