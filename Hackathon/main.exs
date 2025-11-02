# main.exs
# main.exs
Code.require_file("domain/participante.ex")
Code.require_file("domain/equipo.ex")
Code.require_file("domain/proyecto.ex")
Code.require_file("domain/hackathon.ex")
Code.require_file("services/gestion_equipos.ex")
Code.require_file("app/menu.ex")

# Llama al menú principal



alias Domain.Participante
alias Services.GestionEquipos

defmodule Main do
  def run do

    App.Menu.iniciar()

    # IO.puts("Simulación de gestión de equipos en la Hackathon Code4Future\n")

    # # Lista inicial
    # lista_equipos = []

    # # # Crear  equipos
    # lista_equipos = GestionEquipos.crear_equipo("Phoenix Coders", "Educación", lista_equipos)
    # lista_equipos = GestionEquipos.crear_equipo("EcoTech", "Medio Ambiente", lista_equipos)
    # lista_equipos = GestionEquipos.crear_equipo("AI4Good", "IA", lista_equipos)

    # # Crear participantes
    # p1 = Participante.crear("JoJo", :estudiante, "jojo@uq.com")
    # p2 = Participante.crear("Buba", :mentor, "buba@uq.com")
    # p3 = Participante.crear("Tristo", :organizador, "tristo@uq.com")

    # # # Agregar participantes
    # lista_equipos = GestionEquipos.agregar_participante("Phoenix Coders", p1, lista_equipos)
    # lista_equipos = GestionEquipos.agregar_participante("Phoenix Coders", p2, lista_equipos)
    # lista_equipos = GestionEquipos.agregar_participante("EcoTech", p3, lista_equipos)

    # # # Listar equipos finales
    # GestionEquipos.listar_equipos(lista_equipos)

    # lista_equipos = GestionEquipos.eliminar_participante("Phoenix Coders", p1, lista_equipos)
    # GestionEquipos.listar_equipos(lista_equipos)


  end
end

Main.run()
