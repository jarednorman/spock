defmodule SpockBotTest do
  use ExUnit.Case, async: true
  alias Spock.Bot

  @rock_bot_path "bots/rock"
  @copy_bot_path "bots/copy"

  test "checking the bot name" do
    rock = Bot.new(@rock_bot_path)
    copy = Bot.new(@copy_bot_path)
    Bot.end_run(rock)
    Bot.end_run(copy)
    assert rock[:name] == "rock rock rock"
    assert copy[:name] == "copycat"
  end

  test "reading commands" do
    rock = Bot.new(@rock_bot_path)
    move = rock |> Bot.next_move
    Bot.end_run(rock)
    assert move == "rock"
  end

  test "ending the run" do
    bot = Bot.new(@rock_bot_path)
    assert Bot.is_running?(bot)
    Bot.end_run(bot)
    refute Bot.is_running?(bot)
  end

  test "reporting results" do
    copy = Bot.new(@copy_bot_path)
    move = Bot.next_move(copy)
    assert move == "rock"

    Bot.report_result(copy, "loss")
    move = Bot.next_move(copy)
    assert move == "paper"

    Bot.report_result(copy, "loss")
    move = Bot.next_move(copy)
    assert move == "scissors"

    Bot.report_result(copy, "tie")
    move = Bot.next_move(copy)
    assert move == "scissors"

    Bot.report_result(copy, "win")
    move = Bot.next_move(copy)
    assert move == "paper"

    Bot.end_run(copy)
  end
end
