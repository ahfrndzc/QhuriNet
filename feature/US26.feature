Feature: US26 - Visualizar puntos en el mapa
    Como joven eco-consciente,
    Quiero ver los puntos de recolección en un mapa,
    Para identificar facilmente las opciones cercanas.

Scenario Outline: Visualización inicial del mapa con íconos diferenciados
    Dado que el <usuario_autenticado> haya iniciado sesión
    Y se encuentre en la <seccion_search>
    Cuando abra el mapa en pantalla principal
    Entonces el sistema deberá mostrar el <mapa_visible> con <iconos_diferenciados> por categoría

    Examples: Datos de entrada
        | usuario_autenticado                   | seccion_search    |
        | jsm0502@gmail.com (Eco-consciente)    | "Search"          |
        | bodega.ecomart@email.com (Bodega)     | "Search"          |
    
    Examples: Datos de salida
        | mapa_visible          | iconos_diferenciados                                          |
        | [Interfaz de mapa]    | [Icono 'comercio'], [Icono 'reciclador'], [Icono 'municipal']   |
        | [Interfaz de mapa]    | [Icono 'comercio'], [Icono 'reciclador'], [Icono 'municipal']   |

Scenario Outline: Selección de un punto en el mapa
    Dado que el <usuario_autenticado> se encuentre en el <mapa_interactivo>
    Cuando presione sobre un <marcador_especifico>
    Entonces el sistema deberá desplegar un <recuadro_flotante> con la <info_detallada_punto>

    Examples: Datos de entrada
        | usuario_autenticado                   | mapa_interactivo      | marcador_especifico                       |
        | jsm0502@gmail.com                     | [Interfaz de mapa]    | [Icono 'Comercio Acopio Norte']           |
        | jsm0502@gmail.com                     | [Interfaz de mapa]    | [Icono 'Reciclador Municipal San Borja']  |

    Examples: Datos de salida
        | recuadro_flotante     | info_detallada_punto                                              |
        | [Pop-up]              | "Dirección: Av. Paz, Materiales: Plástico, Calificación: 4.5"     |
        | [Pop-up]              | "Dirección: Calle 2, Materiales: Vidrio/Papel, Calificación: 4.2" |