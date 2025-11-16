defmodule App.Menu do
  @moduledoc """
  Menú principal de la aplicación de gestión de una hackathon.
  Permite administrar participantes, equipos, proyectos y reportes.
  """

  alias Domain.{Hackathon, Equipo, Participante, Proyecto}
  alias Services.GestionEquipos
  alias Services.GestionParticipantes


  # ==============================
  # PUNTO DE ENTRADA
  # ==============================
  def iniciar() do
    IO.puts("""
    ======================================
           GESTIÓN HACKATHON CODE4FUTURE
    ======================================
    """)

    hackathon = Hackathon.nueva("Code4Future")
    menu_principal(hackathon)
  end

  # ==============================
  # MENÚ PRINCIPAL
  # ==============================
  defp menu_principal(hackathon) do
    IO.puts("""
    Menú principal:
    1. Gestionar Participantes
    2. Gestionar Equipos
    3. Gestionar Proyectos
    4. Reportes / Listados
    5. Configuración de la Hackathon
    6. Salir
    """)

    opcion = IO.gets("Selecciona una opción: ") |> String.trim()

    case opcion do
      "1" -> menu_participantes(hackathon)
      "2" -> menu_equipos(hackathon)
      "3" -> menu_proyectos(hackathon)
      "4" -> menu_reportes(hackathon)
      "5" -> menu_configuracion(hackathon)
      "6" -> IO.puts("\nSaliendo del sistema... ¡Hasta pronto!\n")
      _ ->
        IO.puts("Opción inválida.\n")
        menu_principal(hackathon)
    end
  end

  # ==============================
  # MENÚ PARTICIPANTES
  # ==============================
  defp menu_participantes(hackathon) do
    IO.puts("""
    ---- MENÚ DE PARTICIPANTES ----
    1. Crear participante
    2. Listar participantes
    3. Buscar participante por nombre
    4. Volver al menú principal
    """)

    opcion = IO.gets("Selecciona una opción: ") |> String.trim()

    case opcion do
      "1" ->
        nombre = IO.gets("Nombre: ") |> String.trim()
        rol = IO.gets("Rol (estudiante/mentor/organizador): ") |> String.trim()
        email = IO.gets("Email: ") |> String.trim()
        id = IO.gets("Email: ") |> String.trim()
        #Participante.crear(id, nombre, String.to_atom(rol), email)
        #nuevo = Hackathon.agregar_participante(hackathon, participante)
        IO.puts(GestionParticipantes.crear(id, nombre, String.to_atom(rol), email))
        menu_participantes(hackathon)

      "2" ->
        listar_participantes(hackathon)
        menu_participantes(hackathon)

      "3" ->
        nombre = IO.gets("Nombre a buscar: ") |> String.trim()
        Hackathon.buscar_participante(hackathon, nombre)
        menu_participantes(hackathon)

      "4" ->
        menu_principal(hackathon)

      _ ->
        IO.puts("Opción inválida.\n")
        menu_participantes(hackathon)
    end
  end

  defp listar_participantes(hackathon) do
    if Enum.empty?(hackathon.participantes) do
      IO.puts("No hay participantes registrados.\n")
    else
      IO.puts("\nParticipantes registrados:")
      Enum.each(hackathon.participantes, fn p ->
        IO.puts("- #{p.nombre} (#{p.rol}) - #{p.email}")
      end)
      IO.puts("")
    end
  end

  # ==============================
  # MENÚ EQUIPOS
  # ==============================
  defp menu_equipos(hackathon) do
    IO.puts("""
    ---- MENÚ DE EQUIPOS ----
    1. Crear equipo
    2. Agregar participante a equipo
    3. Eliminar participante de equipo
    4. Listar equipos
    5. Volver al menú principal
    """)

    opcion = IO.gets("Selecciona una opción: ") |> String.trim()

    case opcion do
      "1" ->
        nombre = IO.gets("Nombre del equipo: ") |> String.trim()
        categoria = IO.gets("Categoría: ") |> String.trim()
        equipo = Equipo.crear(nombre, categoria)
        nuevo = Hackathon.agregar_equipo(hackathon, equipo)
        IO.puts("Equipo creado.\n")
        menu_equipos(nuevo)

      "2" ->
        nombre_equipo = IO.gets("Equipo: ") |> String.trim()
        nombre_participante = IO.gets("Participante a agregar: ") |> String.trim()
        nuevo = Hackathon.asignar_participante_a_equipo(hackathon, nombre_participante, nombre_equipo)
        IO.puts("Participante agregado.\n")
        menu_equipos(nuevo)

      "3" ->
        nombre_equipo = IO.gets("Equipo: ") |> String.trim()
        nombre_participante = IO.gets("Participante a eliminar: ") |> String.trim()
        nuevo = Hackathon.eliminar_participante_de_equipo(hackathon, nombre_participante, nombre_equipo)
        IO.puts("Participante eliminado.\n")
        menu_equipos(nuevo)

      "4" ->
        GestionEquipos.listar_equipos(hackathon.equipos)
        menu_equipos(hackathon)

      "5" ->
        menu_principal(hackathon)

      _ ->
        IO.puts("Opción inválida.\n")
        menu_equipos(hackathon)
    end
  end

  # ==============================
  # MENÚ PROYECTOS
  # ==============================
  defp menu_proyectos(hackathon) do
    IO.puts("""
    ---- MENÚ DE PROYECTOS ----
    1. Crear proyecto
    2. Listar proyectos
    3. Asignar equipo a proyecto
    4. Volver al menú principal
    """)

    opcion = IO.gets("Selecciona una opción: ") |> String.trim()

    case opcion do
      "1" ->
        nombre = IO.gets("Nombre del proyecto: ") |> String.trim()
        descripcion = IO.gets("Descripción: ") |> String.trim()
        proyecto = Proyecto.crear(nombre, descripcion)
        nuevo = Hackathon.agregar_proyecto(hackathon, proyecto)
        IO.puts("Proyecto creado.\n")
        menu_proyectos(nuevo)

      "2" ->
        Hackathon.listar_proyectos(hackathon)
        menu_proyectos(hackathon)

      "3" ->
        nombre_proyecto = IO.gets("Proyecto: ") |> String.trim()
        nombre_equipo = IO.gets("Equipo a asignar: ") |> String.trim()
        nuevo = Hackathon.asignar_equipo_a_proyecto(hackathon, nombre_proyecto, nombre_equipo)
        IO.puts("Equipo asignado.\n")
        menu_proyectos(nuevo)

      "4" ->
        menu_principal(hackathon)

      _ ->
        IO.puts("Opción inválida.\n")
        menu_proyectos(hackathon)
    end
  end

  # ==============================
  # MENÚ REPORTES
  # ==============================
  defp menu_reportes(hackathon) do
    IO.puts("""
    ---- MENÚ DE REPORTES ----
    1. Listar todos los equipos y sus participantes
    2. Contar participantes totales
    3. Volver al menú principal
    """)

    opcion = IO.gets("Selecciona una opción: ") |> String.trim()

    case opcion do
      "1" ->
        GestionEquipos.listar_equipos(hackathon.equipos)
        menu_reportes(hackathon)

      "2" ->
        total = length(hackathon.participantes)
        IO.puts("Hay #{total} participantes registrados.\n")
        menu_reportes(hackathon)

      "3" ->
        menu_principal(hackathon)

      _ ->
        IO.puts("Opción inválida.\n")
        menu_reportes(hackathon)
    end
  end

  # ==============================
  # CONFIGURACIÓN DE LA HACKATHON
  # ==============================
  defp menu_configuracion(hackathon) do
    IO.puts("""
    ---- CONFIGURACIÓN ----
    1. Ver nombre de la hackathon
    2. Cambiar nombre de la hackathon
    3. Volver al menú principal
    """)

    opcion = IO.gets("Selecciona una opción: ") |> String.trim()

    case opcion do
      "1" ->
        IO.puts("Nombre actual: #{hackathon.nombre}\n")
        menu_configuracion(hackathon)

      "2" ->
        nuevo_nombre = IO.gets("Nuevo nombre: ") |> String.trim()
        nuevo = %{hackathon | nombre: nuevo_nombre}
        IO.puts("Nombre actualizado.\n")
        menu_configuracion(nuevo)

      "3" ->
        menu_principal(hackathon)

      _ ->
        IO.puts("Opción inválida.\n")
        menu_configuracion(hackathon)
    end
  end
end
