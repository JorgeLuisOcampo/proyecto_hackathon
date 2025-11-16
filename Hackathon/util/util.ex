defmodule Util do
  def show_message(message) do
    message
    |> IO.puts()
  end

  def input(message, :string) do
    message
    |> IO.gets()
    |> String.trim()
  end

  def input(message, :integer) do
    try do
      message
      |> input(:string)
      |> String.to_integer()
    rescue
      ArgumentError ->
        show_message("Error: Input is not a valid integer.")

      message
      |> input(:integer)
    end
  end

  def input(message, :float) do
    try do
      message
      |> input(:string)
      |> String.to_float()
    rescue
      ArgumentError ->
        show_message("Error: Input is not a valid float.")

      message
      |> input(:float)
    end
  end

  def escribir_csv(lista_participantes, nombre_archivo) do
    headers = "Id,nombre,rol,email,equipo\n"

    contenido =
      Enum.map(lista_participantes,
        fn %Participante{Id,nombre,rol,email,equipo} ->
        "#{nombre}, #{cedula}\n"
      end)
      |> Enum.join()

    File.write(nombre_archivo, headers <> contenido)
  end

  def leer_csv(nombre_archivo) do # Funcion para leer archivo

    case File.read(nombre_archivo) do # Case para manejar errores
      {:ok, contenido} -> # Correcta lectura
        String.split(contenido, "\n") # Separa linea por linea
        |> Enum.map(fn line -> #Recorrer cada linea
          case String.split(line, ", ") do # Separa informacion por coma
            ["Nombre", "Cedula"] -> nil # Ignorar headers
            [nombre, cedula] -> #Verificar pattern maching
              %Cliente{nombre: nombre, cedula: cedula} # Crear struct
            _ -> nil
          end
        end)
          |> Enum.filter(& &1) # Filtra nil y falsy values

      {:error, reason} -> # Error al leer
        IO.puts("Error al leer el archivo: #{reason}")
        []
    end
  end
end
