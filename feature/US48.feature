Feature: US48 - Soporte y atención al cliente
    Como usuario (joven eco-consciente o bodega),
    Quiero reportar incidencias, contactar a soporte y resolver problemas,
    Para solventar mis dudas y procurar que el funcionamiento de la app sea el correcto.

Scenario Outline: El usuario accede al centro de soporte (FAQ)
    Dado que el <usuario_rol> quiere respuestas rápidas a preguntas cotidianas
    Cuando se dirige a la pestaña "Soporte al cliente" y selecciona la opción "FAQ"
    Entonces el sistema lo redirige a la pantalla de FAQ
    Y le muestra la <lista_preguntas_frecuentes> con sus respuestas

    Examples: Datos de entrada
        | usuario_rol           |
        | Joven Eco-consciente  |
        | Bodega                |
    
    Examples: Datos de salida
        | lista_preguntas_frecuentes                                            |
        | [Pregunta 1: "¿Cómo registro material?", Respuesta 1: "Ve a..."]        |
        | [Pregunta 2: "¿Cómo veo mi historial?", Respuesta 2: "Ingresa a..."]   |

Scenario Outline: El usuario busca asistencia personalizada (Envío de Formulario)
    Dado que el <usuario_rol> tiene una duda específica y accede al "Formulario de soporte"
    Cuando completa los campos <nombre>, <apellidos>, <correo>, <mensaje> y presiona "Enviar"
    Entonces el sistema crea un <caso_soporte>
    Y muestra el <mensaje_confirmacion> en pantalla

    Examples: Datos de entrada
        | usuario_rol           | nombre    | apellidos | correo                | mensaje                       |
        | Bodega                | Ana       | Torres    | ana.torres@bodega.com | "No puedo ver mi historial"     |
        | Joven Eco-consciente  | Carlos    | Solis     | c.solis@email.com     | "Mi ruta no se guardó"          |

    Examples: Datos de salida
        | caso_soporte                      | mensaje_confirmacion                                                  |
        | {ticket: #1234, estado: "Pendiente"}  | "Mensaje enviado. En breve, el área de soporte se contactará con usted."  |
        | {ticket: #1235, estado: "Pendiente"}  | "Mensaje enviado. En breve, el área de soporte se contactará con usted."  |

Scenario Outline: Validación de campos del formulario de soporte (Tarea T03)
    Dado que el <usuario_rol> está en el "Formulario de soporte"
    Cuando intenta presionar "Enviar" con <campos_invalidos>
    Entonces el sistema aplica <estilos_error> a los campos incorrectos
    Y muestra un <mensaje_error> de validación

    Examples: Datos de entrada
        | usuario_rol           | campos_invalidos                                              |
        | Bodega                | nombre="Ana", apellidos="Torres", correo="ana.torres", mensaje=""   |
        | Joven Eco-consciente  | nombre="", apellidos="", correo="c.solis@email.com", mensaje="Hola" |

    Examples: Datos de salida
        | estilos_error                 | mensaje_error                             |
        | Borde rojo en campo 'mensaje' | "El campo 'mensaje' es obligatorio"       |
        | Borde rojo en 'nombre' y 'apellidos' | "Los campos 'nombre' y 'apellidos' son obligatorios" |