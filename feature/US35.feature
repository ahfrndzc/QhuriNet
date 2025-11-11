Feature: US35 - Registro y gestión del perfil del usuario
    Como joven eco-consciente o bodega,
    Quiero registrarme con mi correo electrónico, cuenta de Google o Facebook,
    Para acceder rápidamente a la app.

Scenario Outline: Registro con correo electrónico
    Dado que el <usuario_rol> quiere registrarse en la pantalla de "Registro"
    Cuando ingresa sus <nombre>, <correo>, <celular>, <rol>, <contrasena> y presiona "Registrarse"
    Entonces la aplicación envía un <email_verificacion> a su correo
    Y muestra un <mensaje_pendiente> en pantalla

    Examples: Datos de entrada
        | usuario_rol           | nombre          | correo                  | celular   | rol       | contrasena     |
        | Joven Eco-consciente  | Luis Arias      | luis.arias@email.com    | 987654321 | Ciudadano | pass123        |
        | Bodega                | Bodega EcoMart  | ecomart@email.com       | 999888777 | Bodega    | bodegaSegura   |
    
    Examples: Datos de salida
        | email_verificacion              | mensaje_pendiente                         |
        | Email con link de verificación  | "Revisa tu correo para verificar la cuenta" |

Scenario Outline: Registro con cuenta de Google o Facebook
    Dado que el <usuario_rol> quiere registrarse rápidamente en la pantalla de "Registro"
    Cuando elige registrarse con <proveedor_social> y autentica su <cuenta_social>
    Entonces la aplicación crea la cuenta y autentica al <usuario_social> inmediatamente
    Y lo redirige a la <pantalla_principal>

    Examples: Datos de entrada
        | usuario_rol           | proveedor_social  | cuenta_social                   |
        | Joven Eco-consciente  | Google            | jsm0502@gmail.com               |
        | Bodega                | Facebook          | bodega.ecomart@facebook.com     |

    Examples: Datos de salida
        | usuario_social                  | pantalla_principal  |
        | jsm0502@gmail.com               | "Home"              |
        | bodega.ecomart@facebook.com     | "Home"              |

Scenario Outline: Error de registro
    Dado que el <usuario_rol> intenta registrarse en la aplicación
    Cuando ingresa <datos_invalidos> o usa un <correo_ya_registrado>
    Entonces la aplicación debe mostrar un <mensaje_error> claro indicando el motivo

    Examples: Datos de entrada (Datos incompletos)
        | usuario_rol   | datos_invalidos                                | correo_ya_registrado  |
        | Bodega        | nombre="", correo="test@e.com", contrasena="123" | N/A                   |

    Examples: Datos de salida (Datos incompletos)
        | mensaje_error                 |
        | "Faltan campos obligatorios"  |

    Examples: Datos de entrada (Correo duplicado)
        | usuario_rol           | datos_invalidos | correo_ya_registrado          |
        | Joven Eco-consciente  | N/A             | luis.arias@email.com (existe) |

    Examples: Datos de salida (Correo duplicado)
        | mensaje_error                 |
        | "Este correo ya está en uso"  |
