defmodule Spock.Bot do
  def new(folder) do
    Port.open({:spawn, "./#{folder}/player"}, [:binary, {:line, 100}])
  end

  def next_move(bot) do
    send(bot, {self, {:command, "next\n"}})
    receive do
      {^bot, {:data, {:eol, move}}} -> move
    end
  end
end

defmodule SpockBotTest do
  use ExUnit.Case
  alias Spock.Bot

  @random_bot_folder "random_bot"
  @valid_moves ["rock", "paper", "scissors"]

  test "it reads commands" do
    bot = Bot.new(@random_bot_folder)

    move = Bot.next_move(bot)
    assert Enum.any?(@valid_moves, &(move == &1))

    move = Bot.next_move(bot)
    assert Enum.any?(@valid_moves, &(move == &1))

    move = Bot.next_move(bot)
    assert Enum.any?(@valid_moves, &(move == &1))
  end
end
