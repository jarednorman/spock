defmodule SpockBotTest do
  use ExUnit.Case
  alias Spock.Bot

  @rock_bot_path "bots/rock"

  test "checking the bot name" do
    assert Bot.new(@rock_bot_path)[:name] == "rock rock rock"
  end

  test "reading commands" do
    move = Bot.new(@rock_bot_path) |> Bot.next_move
    assert move == "rock"
  end

  test "ending the run" do
    bot = Bot.new(@rock_bot_path)
    assert Bot.is_running?(bot)
    Bot.end_run(bot)
    refute Bot.is_running?(bot)
  end
end
