defmodule Spock.Bot do
  @derive [Access]
  defstruct name: "", pid: nil

  def new(folder) do
    pid = Port.open({:spawn, "./#{folder}/player"}, [:binary, {:line, 100}])
    name = get_name(pid)
    %Spock.Bot{pid: pid, name: name}
  end

  def get_name(pid) do
    receive do
      {^pid, {:data, {:eol, name}}} -> name
    end
  end

  def next_move(%Spock.Bot{pid: pid}) do
    send(pid, {self, {:command, "next\n"}})
    receive do
      {^pid, {:data, {:eol, move}}} -> move
    end
  end
end
