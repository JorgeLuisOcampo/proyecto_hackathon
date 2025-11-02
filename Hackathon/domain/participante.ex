defmodule Domain.Participante do
  @moduledoc """
  Define la estructura base de un participante en la Hackathon.
  Cada participante puede ser un estudiante, mentor o parte de la organización.
  """

  defstruct [
    :id,
    :nombre,
    :rol,
    :email,
    equipo: nil
  ]

  @type rol :: :estudiante | :mentor | :organizador

  @type t :: %__MODULE__{
          id: String.t(),
          nombre: String.t(),
          rol: rol(),
          email: String.t(),
          equipo: String.t() | nil
        }

  @doc """
  Crea un nuevo participante con un id único.
  """
  def crear(nombre, rol, email) when rol in [:estudiante, :mentor, :organizador] do
    %__MODULE__{
      id: generar_id(),
      nombre: nombre,
      rol: rol,
      email: email
    }
  end

  @doc """
  Asigna un participante a un equipo específico.
  """
  def asignar_equipo(%__MODULE__{} = participante, nombre_equipo) when is_binary(nombre_equipo) do
    %{participante | equipo: nombre_equipo}
  end

  # Genera un id único.
  defp generar_id do
    :crypto.strong_rand_bytes(6)
    |> Base.encode16(case: :lower)
  end
end
