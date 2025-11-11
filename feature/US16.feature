Feature: US16 - Sistema de puntos por reciclaje
    Como joven eco-consciente o bodega/pequeño comercio,
    Quiero acumular puntos digitales por cada entrega de residuos,
    Para motivarme a reciclar de forma continua.

Scenario Outline: Consulta de puntos acumulados
    Dado que el <usuario_autenticado> desea consultar sus puntos acumulados
    Cuando ingresa en la sección de "Mi Perfil"
    Entonces el sistema deberá mostrar el <total_puntos_acumulados> y el <porcentaje_avance_meta>
    Y muestra el <mensaje_contextual>

    Examples: Datos de entrada
        | usuario_autenticado                   | sistema_puntaje (Datos en BD)                         |
        | jsm0502@gmail.com (Eco-consciente)    | {total: 1200, meta_mes: 2000, registro: "Ene 2024"}   |
        | bodega.ecomart@email.com (Bodega)     | {total: 8500, meta_mes: 10000, registro: "Mar 2023"}  |
    
    Examples: Datos de salida
        | total_puntos_acumulados | porcentaje_avance_meta    | mensaje_contextual                |
        | "1200 Puntos"           | "60% de tu meta mensual"  | "Ciudadano activo desde Ene 2024" |
        | "8500 Puntos"           | "85% de tu meta mensual"  | "Bodega activa desde Mar 2023"    |

Scenario Outline: Actualización automática de puntos por entrega
    Dado que el <usuario_autenticado> registra materiales y la bodega confirma la entrega
    Cuando se produce el <evento_entrega_confirmada> (ej. validación por QR)
    Entonces el sistema calcula los <puntos_calculados> según el <sistema_calculo_puntos>
    Y actualiza el <saldo_actualizado> en el perfil
    Y muestra un <mensaje_confirmacion>

    Examples: Datos de entrada
        | usuario_autenticado                   | evento_entrega_confirmada                         | sistema_calculo_puntos        | saldo_anterior |
        | jsm0502@gmail.com                     | {material: 'Plástico', cantidad: 5, tipo: 'kg'}   | {'Plástico': 10 pts/kg}       | 1200           |
        | bodega.ecomart@email.com              | {material: 'Vidrio', cantidad: 20, tipo: 'kg'}    | {'Vidrio': 5 pts/kg}          | 8500           |

    Examples: Datos de salida
        | puntos_calculados | saldo_actualizado | mensaje_confirmacion                  |
        | 50 Puntos         | "1250 Puntos"     | "Puntos actualizados exitosamente."   |
        | 100 Puntos        | "8600 Puntos"     | "Puntos actualizados exitosamente."   |