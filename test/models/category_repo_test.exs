defmodule Rumbl.CategoryRepoTest do
    use Rumbl.ModelCase
    alias Rumbl.Category

    test "alphabetical/1 orders by name" do    
        Repo.insert(%Category{name: "c"})
        Repo.insert(%Category{name: "a"})
        Repo.insert(%Category{name: "b"})

        query = Category |> Category.alphabetical()
        query = from c in query, select: c.name
        #Book forgot the defualt values
        assert Repo.all(query) == ["Action", "Comedy", "Drama", "Romance", "Sci-fi", "a", "b", "c"]
    end
end