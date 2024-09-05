defmodule RestaurantPlatform.Token do
  use Joken.Config

  @secret "your_secret_key"

  def generate_token(claims) do
    signer = Joken.Signer.create("HS256", @secret)
    {:ok, token, _claims} = Joken.encode_and_sign(claims, signer)
    token
  end
end
