document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector(".soporte-form");
    const btn = document.querySelector(".btn-enviar");

    btn.addEventListener("click", (event) => {
        event.preventDefault();

        const inputs = form.querySelectorAll("input, textarea");

        const nombres = inputs[0].value.trim();
        const apellidos = inputs[1].value.trim();
        const correo = inputs[2].value.trim();
        const mensaje = inputs[3].value.trim();

        if (!nombres || !apellidos || !correo || !mensaje) {
            alert("Por favor, completa todos los campos antes de enviar.");
            return;
        }

        const correoRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!correoRegex.test(correo)) {
            alert("Por favor, ingresa un correo válido.");
            return;
        }

        const mensajeEstado = document.getElementById("mensajeSoporte");

        mensajeEstado.textContent = "¡Mensaje enviado correctamente! Nos pondremos en contacto contigo pronto.";
        mensajeEstado.classList.add("exito");

        inputs.forEach(input => input.value = "");
    });
});
