defmodule Domain.Proyecto do
  @moduledoc """
  Define la estructura y funciones base para representar un proyecto dentro de la Hackathon.
  """

  defstruct [
    :nombre,
    :descripcion,
    :categoria,
    :estado,
    avances: [],
    retroalimentaciones: []
  ]

  @type t :: %__MODULE__{
          nombre: String.t(),
          descripcion: String.t(),
          categoria: String.t(),
          estado: String.t(),
          avances: [String.t()],
          retroalimentaciones: [String.t()]
        }

  @doc """
  Crea un nuevo proyecto con nombre, descripción y categoría.
  El estado inicial será `"En desarrollo"`.
  """
  def crear(nombre, descripcion, categoria) do
    %__MODULE__{
      nombre: nombre,
      descripcion: descripcion,
      categoria: categoria,
      estado: "En desarrollo"
    }
  end

  @doc """
  Registra un nuevo avance en la lista de avances del proyecto.
  """
  def agregar_avance(%__MODULE__{avances: lista} = proyecto, texto) when is_binary(texto) do
    %{proyecto | avances: lista ++ [texto]}
  end

  @doc """
  Cambia el estado del proyecto (por ejemplo: "En desarrollo", "Finalizado", "En revisión").
  """
  def actualizar_estado(%__MODULE__{} = proyecto, nuevo_estado) when is_binary(nuevo_estado) do
    %{proyecto | estado: nuevo_estado}
  end

  @doc """
  Registra una retroalimentación de un mentor asociada al proyecto.
  """
  def agregar_retroalimentacion(%__MODULE__{retroalimentaciones: lista} = proyecto, comentario) do
    %{proyecto | retroalimentaciones: lista ++ [comentario]}
  end
end
