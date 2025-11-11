Feature: US01 - Gestión de Materiales (Registro)
    Como joven eco-consciente o bodega/pequeños comercios,
    Quiero registrar el tipo y cantidad de material reciclable,
    Para evitar acumulación en mi casa.

Scenario Outline: Registro exitoso del material reciclable
    Dado que el <usuario_autenticado> se encuentra en el apartado "Registrar material"
    Cuando completa el formulario con <tipo_material>, <cantidad>, <horario_recojo> y presiona "Registrar"
    Entonces el sistema muestra un <mensaje_confirmacion>
    Y almacena el <material_registrado> en el historial de entregas

    Examples: Datos de entrada
        | usuario_autenticado                   | tipo_material | cantidad      | horario_recojo  |
        | jsm0502@gmail.com (Eco-consciente)    | Plástico      | 5 kg          | Mañana 9-11 AM  |
        | bodega.ecomart@email.com (Bodega)     | Cartón        | 20 kg         | Tarde 3-5 PM    |
        | ana.perez@email.com (Eco-consciente)  | Vidrio        | 30 botellas   | Mañana 10-12 AM |

    Examples: Datos de salida
        | mensaje_confirmacion                  | material_registrado                               |
        | "Registro exitoso del material"       | {tipo: Plástico, estado: Pendiente}                |
        | "Registro exitoso del material"       | {tipo: Cartón, estado: Pendiente}                  |
        | "Registro exitoso del material"       | {tipo: Vidrio, estado: Pendiente}                  |

Scenario Outline: Visualización del material registrado en el historial
    Dado que el <usuario_autenticado> ha registrado un material y accede al apartado de "Mi perfil"
    Cuando visualiza la sección "Entregas y Recojos"
    Entonces el sistema muestra la <lista_entregas_recojos>
    Y puede ver el <detalle_material>, quién lo recoge, la hora y el <estado_recojo>

    Examples: Datos de entrada
        | usuario_autenticado                   | historial_entregas (Datos en el sistema)                               |
        | jsm0502@gmail.com                     | [{id: 1, tipo: 'Plástico', recolector: 'Juan Silva', hora: '10 AM'}]   |
        | bodega.ecomart@email.com              | [{id: 2, tipo: 'Cartón', recolector: 'N/A', hora: 'N/A'}]              |

    Examples: Datos de salida
        | lista_entregas_recojos                | detalle_material          | estado_recojo |
        | [Entrega 1]                           | "Plástico, 5 kg"          | Completado    |
        | [Recojo 1]                            | "Cartón, 20 kg"           | Pendiente     |