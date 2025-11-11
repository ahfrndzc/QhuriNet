Feature: US50 - Contacto telefónico con soporte (vía Footer)
    Como joven eco-consciente o dueño de bodega,
    Quiero poder comunicarme directamente por teléfono con el área de soporte,
    Para recibir asistencia inmediata ante problemas urgentes o dudas específicas.

Scenario Outline: Visualizar información de contacto en el Footer (Tarea T01 y T02)
    Dado que el <usuario_rol> quiere encontrar la información de contacto
    Cuando se desplaza hasta el final de la página (Footer)
    Entonces el sistema muestra la <seccion_footer> con el <numero_telefonico>, <correo_contacto> y <enlaces_redes_sociales>

    Examples: Datos de entrada
        | usuario_rol           |
        | Joven Eco-consciente  |
        | Bodega                |

    Examples: Datos de salida
        | seccion_footer    | numero_telefonico | correo_contacto       | enlaces_redes_sociales                |
        | [Sección Footer]  | +51 987 654 321   | soporte@app.com       | [Icono Facebook], [Icono Instagram]   |

Scenario Outline: Llamada exitosa al soporte (desde Footer)
    Dado que el <usuario_rol> se encuentra en el <seccion_footer>
    Cuando presiona el <numero_telefonico> o la opción "Llamar ahora"
    Entonces el sistema operativo inicia la <marcacion_telefonica>

    Examples: Datos de entrada
        | usuario_rol           | seccion_footer    | numero_telefonico |
        | Joven Eco-consciente  | [Sección Footer]  | +51 987 654 321   |
        | Bodega                | [Sección Footer]  | +51 987 654 321   |
    
    Examples: Datos de salida
        | marcacion_telefonica          |
        | [App de teléfono nativa]      |
        | [App de teléfono nativa]      |

Scenario Outline: Fallo o línea ocupada
    Dado que el <usuario_rol> presiona "Llamar ahora" desde el Footer
    Cuando el dispositivo detecta que la <estado_linea>
    Entonces el sistema (o dispositivo) muestra el <mensaje_error_llamada>

    Examples: Datos de entrada
        | usuario_rol           | estado_linea          |
        | Joven Eco-consciente  | Línea Ocupada         |
        | Bodega                | Fuera de servicio     |
        | Joven Eco-consciente  | Sin señal             |

    Examples: Datos de salida
        | mensaje_error_llamada                             |
        | "No pudimos completar la llamada. Inténtelo más tarde" |
        | "No pudimos completar la llamada. Inténtelo más tarde" |
        | "No pudimos completar la llamada. Inténtelo más tarde" |