
document.addEventListener("DOMContentLoaded", () => {
    
    fetch('chatbot.html') 
        .then(response => {
            if (!response.ok) throw new Error("No se encontró chatbot.html");
            return response.text();
        })
        .then(html => {
            
            const slot = document.getElementById('slot-chatbot');
            if (slot) {
                slot.innerHTML = html;
                
                iniciarLogicaChatbot();
            }
        })
        .catch(error => console.error('Error cargando el chatbot:', error));
});



function iniciarLogicaChatbot() {
    const chatbotToggler = document.querySelector(".chatbot-toggler");
    const closeBtn = document.querySelector(".close-btn");
    const chatbox = document.querySelector(".chatbox");
    const chatInput = document.querySelector(".chat-input textarea");
    const sendChatBtn = document.querySelector(".chat-input span");

    let userMessage = null; 
    let chatStep = 0;      
    let inputHeight = chatInput.scrollHeight;

    // --- Funciones auxiliares ---
    const createChatLi = (message, className) => {
        const chatLi = document.createElement("li");
        chatLi.classList.add("chat", `${className}`);
        let chatContent = className === "outgoing" ? `<p></p>` : `<span>🤖</span><p></p>`;
        chatLi.innerHTML = chatContent;
        chatLi.querySelector("p").textContent = message;
        return chatLi;
    }

    const generateResponse = (incomingChatLi) => {
        const messageElement = incomingChatLi.querySelector("p");
        
        setTimeout(() => {
            if (chatStep === 0) {
                messageElement.textContent = "✅ Hemos validado tu cuenta. Tu correo existe en nuestra base de datos. \n\nAhora, por favor, describe brevemente tu caso o problema:";
                chatStep = 1;  
            } else if (chatStep === 1) {
                messageElement.innerHTML = "Entendido. Basado en tu descripción, aquí tienes algunas soluciones rápidas:<br><br>🔹 <b>Opción A:</b> Revisa nuestra sección de preguntas frecuentes.<br>🔹 <b>Opción B:</b> Reinicia la aplicación.<br><br>Si esto no ayuda, un asesor humano revisará tu caso pronto.";
                chatStep = 2; 
            } else {
                messageElement.textContent = "Gracias por la información adicional. Hemos actualizado tu caso.";
            }
            chatbox.scrollTo(0, chatbox.scrollHeight);
        }, 600); 
    }

    const handleChat = () => {
        userMessage = chatInput.value.trim();
        if(!userMessage) return;

        
        
        if (chatStep === 0) {
            
            const esCorreoValido = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(userMessage);
            
            if (!esCorreoValido) {
                
                chatInput.value = "";
                
                chatbox.appendChild(createChatLi(userMessage, "outgoing"));
                
                
                setTimeout(() => {
                    const errorMsg = "⚠️ Error: Por favor ingresa un correo válido (ejemplo: usuario@gmail.com).";
                    chatbox.appendChild(createChatLi(errorMsg, "incoming"));
                    chatbox.scrollTo(0, chatbox.scrollHeight);
                }, 600);
                return; 
            }
        }

        chatInput.value = "";
        chatInput.style.height = `${inputHeight}px`;

        chatbox.appendChild(createChatLi(userMessage, "outgoing"));
        chatbox.scrollTo(0, chatbox.scrollHeight);

        setTimeout(() => {
            const incomingChatLi = createChatLi("Escribiendo...", "incoming");
            chatbox.appendChild(incomingChatLi);
            chatbox.scrollTo(0, chatbox.scrollHeight);
            generateResponse(incomingChatLi);
        }, 600);
    }

    // --- Event Listeners ---
    chatInput.addEventListener("input", () => {
        chatInput.style.height = `${inputHeight}px`;
        chatInput.style.height = `${chatInput.scrollHeight}px`;
    });

    sendChatBtn.addEventListener("click", handleChat);
    closeBtn.addEventListener("click", () => document.body.classList.remove("show-chatbot"));
    chatbotToggler.addEventListener("click", () => document.body.classList.toggle("show-chatbot"));
    chatInput.addEventListener("keydown", (e) => {
        if(e.key === "Enter" && !e.shiftKey && window.innerWidth > 800) {
            e.preventDefault();
            handleChat();
        }
    });
}