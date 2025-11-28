document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('contactForm');  
  const msgBox = document.getElementById('contacto-msg');
  if (!form) return;

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    const data = new FormData(form);
    const nombres = data.get('nombres').trim();
    const apellidos = data.get('apellidos').trim();
    const correo = data.get('correo').trim();
    const mensaje = data.get('mensaje').trim();

    const errores = [];
    if (!nombres) errores.push('Ingresa tus nombres.');
    if (!apellidos) errores.push('Ingresa tus apellidos.');
    if (!correo || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo))
      errores.push('Ingresa un correo válido.');
    if (!mensaje) errores.push('Escribe tu mensaje.');

    if (errores.length) {
      msgBox.textContent = errores.join(' ');
      msgBox.className = 'form-message error';
      return;
    }

    msgBox.textContent = '✅ ¡Gracias por contactarnos! Te responderemos pronto.';
    msgBox.className = 'form-message success';
    form.reset();
  });
});
