document.addEventListener('DOMContentLoaded', function () {
    const messagesContainer = document.querySelector('.overflow-y-auto');
    const form = document.querySelector('form');
    const textarea = document.getElementById('message_text');

    console.log(textarea);

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
    form.addEventListener('submit', function (event) {
        event.preventDefault(); // Bloquer le rechargement de la page
        event.stopPropagation(); // Empêcher d'autres événements liés

        const formData = new FormData(form);

        fetch(form.action, {
            method: 'POST',
            body: formData,
        })
        .then(response => response.json()) // Attend une réponse JSON
        .then(data => {
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
                
                // Effacer le champ après envoi
                textarea.value = '';
                console.log("textareavalue");

            }
        })
        .catch(error => console.error('Erreur lors de l\'envoi du message:', error));
    });
});
 