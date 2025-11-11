Feature: US43 - Consultar historial de materiales (Impacto Ambiental)
    Como joven eco-consciente o bodega,
    Quiero visualizar un historial estadístico general sobre los materiales reciclados.
    (Para llevar un control de mis acciones)

Scenario Outline: Visualizar cantidad materiales reciclados (Últimos 6 meses)
    Dado que el <usuario_autenticado> quiere ver la cantidad de materiales reciclados en los últimos 6 meses
    Cuando se dirige a la pestaña "Home" y visualiza la sección "Impacto Ambiental" (opción "Reciclaje por mes")
    Entonces el sistema mostrará un <grafico_area_visible> sobre la cantidad de materiales reciclados por el usuario

    Examples: Datos de entrada
        | usuario_autenticado                   | datos_historial_6_meses (Datos en BD)                         |
        | jsm0502@gmail.com (Eco-consciente)    | {Jun: 10, Jul: 15, Ago: 12, Sep: 20, Oct: 18, Nov: 25} (kg)   |
        | bodega.ecomart@email.com (Bodega)     | {Jun: 100, Jul: 150, Ago: 120, Sep: 200, Oct: 180, Nov: 250} (kg) |
    
    Examples: Datos de salida
        | grafico_area_visible  | datos_graficados_area                 |
        | [Gráfico de Área]     | [Visualización de datos Jun-Nov]      |
        | [Gráfico de Área]     | [Visualización de datos Jun-Nov]      |

Scenario Outline: Visualizar tipos de materiales reciclados (Mes actual)
    Dado que el <usuario_autenticado> desea ver la cantidad de materiales reciclados del mes actual por tipo
    Cuando visualice en "Impacto Ambiental" (Home) el apartado "Distribución de materiales"
    Entonces el sistema mostrará un <grafico_rosca_visible> según los tipos de material junto a sus cantidades

    Examples: Datos de entrada
        | usuario_autenticado                   | datos_mes_actual_por_tipo (Datos en BD)   |
        | jsm0502@gmail.com (Eco-consciente)    | {Plástico: 10kg, Vidrio: 5kg, Papel: 10kg}  |
        | bodega.ecomart@email.com (Bodega)     | {Plástico: 100kg, Vidrio: 50kg, Papel: 100kg}|
    
    Examples: Datos de salida
        | grafico_rosca_visible | leyenda_grafico_rosca                         |
        | [Gráfico de Rosca]    | [Plástico: 40%, Vidrio: 20%, Papel: 40%]      |
        | [Gráfico de Rosca]    | [Plástico: 40%, Vidrio: 20%, Papel: 40%]      |
