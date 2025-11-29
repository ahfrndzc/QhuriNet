document.addEventListener('DOMContentLoaded', () => {
  const loginForm = document.getElementById('loginForm');
  const loginMsg  = document.getElementById('login-msg');

  if (!loginForm || !loginMsg) return;

  loginForm.addEventListener('submit', (e) => {
    e.preventDefault();

    const data = new FormData(loginForm);
    const correo = (data.get('correo') || "").trim();
    const pass   = (data.get('password') || "").trim();

    const raw = localStorage.getItem("qhuriUser");

    if (!raw) {
      loginMsg.textContent = "❌ No existe ninguna cuenta registrada. Primero regístrate.";
      loginMsg.className = "form-message error";
      return;
    }

    let saved;
    try {
      saved = JSON.parse(raw);
    } catch (err) {
      console.error("Error al leer usuario guardado:", err);
      loginMsg.textContent = "❌ Error al leer los datos guardados. Vuelve a registrarte.";
      loginMsg.className = "form-message error";
      return;
    }

    if (correo === saved.correo && pass === saved.password) {
      loginMsg.textContent = "✅ Inicio de sesión exitoso.";
      loginMsg.className = "form-message success";

    } else {
      loginMsg.textContent = "❌ Correo o contraseña incorrectos.";
      loginMsg.className = "form-message error";
    }
  });
});
