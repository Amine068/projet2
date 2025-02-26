document.addEventListener('DOMContentLoaded', function () {
    const messagesContainer = document.querySelector('.overflow-y-auto');
    const form = document.querySelector('form');
    const textarea = document.getElementById('message_text');

    console.log('Script loaded'); // Debug: Check if script is loaded

    // Auto-scroll en bas à l'ouverture
    messagesContainer.scrollTop = messagesContainer.scrollHeight;

    // Actualisation des messages toutes les 3 secondes
    setInterval(function () {
        fetch(window.location.href)
            .then(response => response.text())
            .then(html => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(html, 'text/html');
                const newMessages = doc.querySelector('.overflow-y-auto').innerHTML;
                if (messagesContainer.innerHTML !== newMessages) {
                    messagesContainer.innerHTML = newMessages;
                    messagesContainer.scrollTop = messagesContainer.scrollHeight;
                }
            });
    }, 3000);

    // Interception de la soumission du formulaire
    if (form) { // Ensure the form is found
        form.addEventListener('submit', function (event) {
            console.log('Form submitted'); // Debug: Check if form submission is intercepted
            event.preventDefault(); // Bloquer le rechargement de la page
            event.stopPropagation(); // Empêcher d'autres événements liés

            const formData = new FormData(form);

            fetch(form.action, {
                method: 'POST',
                body: formData,
            })
            .then(response => response.json()) // Parse the JSON response
            .then(data => {
                console.log('Response data:', data); // Debug: Check the response data
                if (data.success) {
                    // Création d'un nouvel élément message
                    const newMessage = document.createElement('div');
                    newMessage.classList.add('flex', 'justify-end'); // Aligné à droite pour l'expéditeur
                    newMessage.innerHTML = `
                        <div class="max-w-[75%] bg-[#004C5E] text-white rounded-lg px-4 py-2">
                            <p>${data.message.text}</p>
                            <p class="text-xs text-blue-100 mt-1">${data.message.writer} - ${data.message.sendDate}</p>
                        </div>
                    `;

                    messagesContainer.appendChild(newMessage);
                    messagesContainer.scrollTop = messagesContainer.scrollHeight;

                    // Clear the input field
                    textarea.value = '';
                }
            })
            .catch(error => console.error('Erreur lors de l\'envoi du message:', error));
        });
    } else {
        console.error('Form not found'); // Debug: Check if form is not found
    }
});
