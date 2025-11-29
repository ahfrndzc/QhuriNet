document.addEventListener('DOMContentLoaded', () => {

  const registerForm = document.getElementById('registerForm');
  const registerMsg  = document.getElementById('register-msg');

  if (!registerForm) return;

  registerForm.addEventListener('submit', (e) => {
    e.preventDefault();

    const data = new FormData(registerForm);

    const nombre   = (data.get('nombre') || "").trim();
    const correo   = (data.get('correo') || "").trim();
    const correo2  = (data.get('correoConfirm') || "").trim();
    const celular  = (data.get('celular') || "").trim();        // 9 dígitos
    const codigo   = (data.get('celularConfirm') || "").trim(); // 4 dígitos
    const rol      = (data.get('rol') || "").trim();
    const pass     = (data.get('password') || "").trim();
    const pass2    = (data.get('passwordConfirm') || "").trim();
    const terminos = data.get('terminos');

    const errores = [];

    if (!nombre) errores.push("Ingresa tu nombre completo.");

    if (!correo) errores.push("Ingresa tu correo electrónico.");
    if (correo && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo))
      errores.push("El correo no tiene un formato válido.");
    if (correo !== correo2)
      errores.push("Los correos no coinciden.");

    if (!/^\d{9}$/.test(celular))
      errores.push("El número de celular debe tener 9 dígitos.");

    if (!/^\d{4}$/.test(codigo))
      errores.push("El código de verificación debe tener 4 dígitos.");

    if (!rol) errores.push("Selecciona un rol.");

    if (!pass) errores.push("Ingresa una contraseña.");
    if (pass !== pass2)
      errores.push("Las contraseñas no coinciden.");

    if (!terminos)
      errores.push("Debes aceptar los términos y condiciones.");


    if (errores.length > 0) {
      registerMsg.textContent = errores.join(" ");
      registerMsg.className = "form-message error";
      return;
    }

    const user = {
      nombre,
      correo,
      celular,
      codigo,
      rol,
      password: pass
    };

    localStorage.setItem("qhuriUser", JSON.stringify(user));

    registerMsg.textContent = "✅ Cuenta creada correctamente. Ahora puedes iniciar sesión.";
    registerMsg.className = "form-message success";

    registerForm.reset();
  });

});
