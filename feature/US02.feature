Feature: US02 - Chat de Coordinación y Calificación
    Como joven eco-consciente o bodega/pequeños comercios,
    Quiero poder conversar con los [recolectores] disponibles,
    Para asegurar que el retiro de mis materiales se realice de manera puntual y organizada.

Scenario Outline: Visualización e inicio de chat con recolector asignado
    Dado que el <usuario_autenticado> tiene <material_registrado> con un <recolector_asignado>
    Cuando visualiza el apartado de "Home" y presiona el <icono_chat> correspondiente
    Entonces se habilita la <ventana_chat_activa> con el recolector
    Y el sistema muestra un <mensaje_confirmacion_conexion>

    Examples: Datos de entrada
        | usuario_autenticado                   | material_registrado     | recolector_asignado | icono_chat                  |
        | jsm0502@gmail.com (Eco-consciente)    | {id: 1, tipo: Plástico} | "Juan Silva"        | [Icono de Chat "Juan Silva"] |
        | bodega.ecomart@email.com (Bodega)     | {id: 2, tipo: Cartón}   | "Maria Reyes"       | [Icono de Chat "Maria Reyes"]|

    Examples: Datos de salida
        | ventana_chat_activa       | mensaje_confirmacion_conexion |
        | [Chat en tiempo real]     | "Conexión establecida."       |
        | [Chat en tiempo real]     | "Conexión establecida."       |

Scenario Outline: Confirmación y calificación del recolector después de la recolección
    Dado que el <usuario_autenticado> se encuentra en "Home" y recibe un <mensaje_confirmacion_recojo>
    Cuando selecciona una <accion_calificar> (1-5 estrellas)
    Y presiona el <boton_enviar_calificacion>
    Entonces el sistema muestra un <mensaje_agradecimiento>
    Y la <calificacion_guardada> actualiza el perfil del recolector

    Examples: Datos de entrada (Enviar calificación)
        | usuario_autenticado                   | mensaje_confirmacion_recojo       | accion_calificar          | boton_enviar_calificacion |
        | jsm0502@gmail.com                     | "Tu recolección ha finalizado"    | (Selección de 5 estrellas)  | [Presionar "Enviar"]      |
    
    Examples: Datos de salida (Enviar calificación)
        | mensaje_agradecimiento            | calificacion_guardada                             |
        | "¡Gracias por tu calificación!"   | {Promedio de 'Juan Silva' actualizado}            |

    Examples: Datos de entrada (Omitir calificación)
        | usuario_autenticado                   | mensaje_confirmacion_recojo       | accion_calificar          | boton_enviar_calificacion |
        | bodega.ecomart@email.com              | "Tu recolección ha finalizado"    | (Sin selección)           | [Presionar "Omitir"]      |

    Examples: Datos de salida (Omitir calificación)
        | mensaje_agradecimiento            | calificacion_guardada                             |
        | N/A (Se cierra la modal)          | {Promedio no cambia}                              |