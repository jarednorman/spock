defmodule SpockBotTest do
  use ExUnit.Case
  alias Spock.Bot

  @random_bot_folder "random_bot"
  @valid_moves ["rock", "paper", "scissors"]

  test "checking the bot name" do
    assert Bot.new(@random_bot_folder)[:name] == "randombot"
  end

  test "reading commands" do
    bot = Bot.new(@random_bot_folder)

    move = Bot.next_move(bot)
    assert Enum.any?(@valid_moves, &(move == &1))

    move = Bot.next_move(bot)
    assert Enum.any?(@valid_moves, &(move == &1))

    move = Bot.next_move(bot)
    assert Enum.any?(@valid_moves, &(move == &1))
  end
end
