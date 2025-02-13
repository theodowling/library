defmodule Library.HTTPoison.InMemory do
  @harry_potter {
    :ok,
    %{
      body: """
        {
          \"items\": [{
            \"volumeInfo\": {
            \"title\": \"hello world\",
            \"authors\": [\"hemingway\"],
            \"industryIdentifiers\": [{\"identifier\": \"isbn_10\", \"type\": \"123\"}]
            }
          }]
        }
      """
    }
  }

  @bad_value {
    :ok,
    %{
      body: """
        {
          \"items\": [{
            \"volumeInfo\": {
            \"title\": \"hello world\"
            }
          }]
        }
      """
    }
  }


  def get("https://www.googleapis.com/books/v1/volumes?maxResults=20&key=&q=+intitle:harry%20potter") do
    @harry_potter
  end
  def get("https://www.googleapis.com/books/v1/volumes?key=&q=intitle:harry%20potter") do
    @harry_potter
  end

  def get("https://www.googleapis.com/books/v1/volumes?maxResults=20&key=&q=+intitle:bad_value") do
    @bad_value
  end
  def get("https://www.googleapis.com/books/v1/volumes?key=&q=intitle:bad_value") do
    @bad_value
  end

  def get("https://www.googleapis.com/books/v1/volumes?key=&q=intitle:bad_json_response") do
    {
      :ok,
      %{
        body: """
          {test: 1"test"}
        """
      }
    }
  end

  def get("https://www.googleapis.com/books/v1/volumes?key=&q=intitle:bad_value2") do
    {:error, "bad"}
  end

  def get("https://api.github.com/user/orgs", [{"Accept", "application/json"}, {"Authorization", "token 456"}]) do
    {:ok, %{body: "[{\"login\":\"dwyl\"}]"}}
  end

  def get("https://api.github.com/user/emails", [{"Accept", "application/json"}, {"Authorization", "token 456"}]) do
    {:ok, %{body: "[{\"primary\":true,\"email\":\"indiana@dwyl.com\"}]"}}
  end

  def get("https://api.github.com/user/orgs", [{"Accept", "application/json"}, {"Authorization", "token 789"}]) do
    {:ok, %{body: "[{\"login\":\"other\"}]"}}
  end

  def get("https://api.github.com/user/emails", [{"Accept", "application/json"}, {"Authorization", "token 789"}]) do
    {:ok, %{body: "[{\"primary\":true,\"email\":\"indiana@dwyl.com\"}]"}}
  end

  def get("https://api.github.com/user/orgs", [{"Accept", "application/json"}, {"Authorization", "token 235"}]) do
    {:error, "bad"}
  end

  def get("https://api.github.com/user/emails", [{"Accept", "application/json"}, {"Authorization", "token 235"}]) do
    {:ok, "[{\"primary\":true,\"email\":\"indiana@dwyl.com\"}]"}
  end

  def get("https://api.github.com/user/orgs", [{"Accept", "application/json"}, {"Authorization", "token 420"}]) do
    {:ok, %{body: "[{\"login\":\"other\"}]"}}
  end

  def get("https://api.github.com/user/emails", [{"Accept", "application/json"}, {"Authorization", "token 420"}]) do
    {:ok, %{body: "{not a:valid:json}"}}
  end

  def get("https://api.github.com/user/orgs", [{"Accept", "application/json"}, {"Authorization", "token 365"}]) do
    {:ok, %{body: "{not a:valid:json}"}}
  end


end
