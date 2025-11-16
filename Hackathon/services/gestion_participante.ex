defmodule Services.GestionParticipantes do

  def crear_participante(nombre, categoria) do
    Hackathon.crear


    case Enum.find(lista_equipos, fn eq -> eq.nombre == nombre end) do
      nil ->
        equipo = %Equipo{nombre: nombre, categoria: categoria}
        [equipo | lista_equipos]

      _ ->
        IO.puts("Ya existe un equipo con el nombre #{nombre}")
        lista_equipos
    end
  end

end
