defmodule Domain.Equipo do
  @moduledoc """
  Define la estructura y funciones base para representar un equipo dentro de la Hackathon.
  """

  defstruct [
    :nombre,
    :categoria,
    participantes: [],
    proyecto: nil,
    chat_id: nil
  ]

  @type t :: %__MODULE__{
          nombre: String.t(),
          categoria: String.t(),
          participantes: [String.t()],
          proyecto: String.t() | nil,
          chat_id: String.t() | nil
        }

  @doc """
  Crea un nuevo equipo con un nombre, categoría y lista opcional de participantes.
  """
  def crear(nombre, categoria, participantes \\ []) do
    %__MODULE__{
      nombre: nombre,
      categoria: categoria,
      participantes: participantes
    }
  end

  @doc """
  Agrega un participante al equipo si aún no está registrado.
  """
  def agregar_participante(equipo, participante) do
    if participante in equipo.participantes do
      {:error, :participante_ya_existe}
    else
      %{equipo | participantes: equipo.participantes ++ [participante]}
    end
  end

  @doc """
  Asocia un proyecto al equipo.
  """
  def asignar_proyecto(%__MODULE__{} = equipo, nombre_proyecto) do
    %{equipo | proyecto: nombre_proyecto}
  end

  @doc """
  Asocia un canal de chat al equipo.
  """
  def asignar_chat(%__MODULE__{} = equipo, chat_id) do
    %{equipo | chat_id: chat_id}
  end
end
