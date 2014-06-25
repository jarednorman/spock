defmodule Spock.Bot do

  @derive [Access]
  defstruct name: "", pid: nil
  alias Spock.Bot

  def new(path) do
    pid = Port.open({:spawn, Path.join([".", path, "player"])}, [:binary, {:line, 100}])
    name = get_name(pid)
    %Bot{pid: pid, name: name}
  end

  def get_name(pid) do
    receive do
      {^pid, {:data, {:eol, name}}} -> name
    end
  end

  def next_move(%Bot{pid: pid}) do
    send(pid, {self, {:command, "next\n"}})
    receive do
      {^pid, {:data, {:eol, move}}} -> move
    end
  end

  def end_run(%Bot{pid: pid}) do
    send(pid, {self, {:command, "done\n"}})
    receive do
      {^pid, {:data, {:eol, "okay"}}} ->
    end
    Port.close(pid)
  end

  def is_running?(%Bot{pid: pid}) do
    Port.info(pid) != :undefined
  end
end
