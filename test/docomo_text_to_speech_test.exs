defmodule DocomoTextToSpeechTest do
  use ExUnit.Case
  doctest DocomoTextToSpeech

  test "greets the world" do
    assert DocomoTextToSpeech.hello() == :world
  end
end
