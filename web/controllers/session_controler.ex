defmodule Rumbl.SessionController do
    use Rumbl.Web, :controller

    def new(conn, _) do
        render conn, "new.html"
    end

    def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
        case Rumbl.Auth.login_by_username_and_password(conn, user, pass, repo: Repo) do
            {:ok, conn} ->
                conn
                |> put_flash(:info, "Welcome back!")
                |> redirect(to: page_path(conn, :index))
            {:error, _reason, _changeset} ->
                conn
                |> put_flash(:error, "Invalid username/password combinatation")
                |> render("new.html")
        end
    end

    def delete(conn, _) do
        conn
        |> Rumbl.Auth.logout()
        |> redirect(to: page_path(conn, :index))
    end
end