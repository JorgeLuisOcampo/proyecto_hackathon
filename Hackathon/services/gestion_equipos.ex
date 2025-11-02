defmodule Services.GestionEquipos do
  @moduledoc """
  Módulo de servicio encargado de la gestión de equipos en la hackathon.
  Permite crear nuevos equipos, listar los existentes y agregar participantes.
  """

  alias Domain.Equipo
  alias Domain.Participante

  # Crea un equipo si no existe otro con el mismo nombre
  def crear_equipo(nombre, categoria, lista_equipos) do
    case Enum.find(lista_equipos, fn eq -> eq.nombre == nombre end) do
      nil ->
        equipo = %Equipo{nombre: nombre, categoria: categoria}
        [equipo | lista_equipos]

      _ ->
        IO.puts("Ya existe un equipo con el nombre #{nombre}")
        lista_equipos
    end
  end

  # Agrega un participante a un equipo existente
  def agregar_participante(nombre_equipo, participante, lista_equipos) do
    case Enum.find(lista_equipos, fn e -> e.nombre == nombre_equipo end) do
      nil ->
        {:error, "No se encontró el equipo #{nombre_equipo}"}

      equipo ->
        actualizado = Equipo.agregar_participante(equipo, participante)
        nueva_lista =
          Enum.map(lista_equipos, fn e ->
            if e.nombre == nombre_equipo, do: actualizado, else: e
          end)

        nueva_lista
    end
  end

    def eliminar_participante(nombre_equipo, participante, lista_equipos) do
    case Enum.find(lista_equipos, fn e -> e.nombre == nombre_equipo end) do
      nil ->
        {:error, "No se encontró el equipo #{nombre_equipo}"}

      equipo ->
        actualizado = Equipo.eliminar_participante(equipo, participante)
        nueva_lista =
          Enum.map(lista_equipos, fn e ->
            if e.nombre == nombre_equipo, do: actualizado, else: e
          end)

        nueva_lista
    end
  end

  # Lista todos los equipos registrados
  def listar_equipos(lista_equipos) do
    if lista_equipos == [] do
      IO.puts("No hay equipos registrados.")
    else
      IO.puts("Equipos registrados:")
      Enum.each(lista_equipos, fn eq ->
        IO.puts("- #{eq.nombre} (#{eq.categoria})")

        if eq.participantes == [] do
          IO.puts("  Sin participantes aún.")
        else
          Enum.with_index(eq.participantes, 1)
          |> Enum.each(fn {p, i} ->
            IO.puts("   #{i}. #{p.nombre}, rol: #{p.rol}")
          end)
        end
      end)
    end
  end

end
