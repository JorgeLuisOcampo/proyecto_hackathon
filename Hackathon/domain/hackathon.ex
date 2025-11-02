defmodule Domain.Hackathon do
  @moduledoc """
  Representa una hackathon con sus equipos, participantes y proyectos.
  """

  alias Domain.Equipo
  alias Domain.Participante

  defstruct [
    nombre: "",
    equipos: [],
    participantes: [],
    proyectos: []
  ]

  # Crear una hackathon vacía
  def nueva(nombre) do
    %__MODULE__{nombre: nombre}
  end

  # Agregar un equipo
  def agregar_equipo(%__MODULE__{equipos: equipos} = hackathon, equipo) do
    %{hackathon | equipos: [equipo | equipos]}
  end

  # Agregar un participante
  def agregar_participante(%__MODULE__{participantes: participantes} = hackathon, participante) do
    %{hackathon | participantes: [participante | participantes]}
  end

  # Buscar un equipo
  def buscar_equipo(%__MODULE__{equipos: equipos}, nombre) do
    Enum.find(equipos, fn e -> e.nombre == nombre end)
  end
end
