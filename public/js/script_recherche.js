document.addEventListener('DOMContentLoaded', function() {
    const categorySelect = document.getElementById('categoryFilter');
    const subCategorySelect = document.getElementById('subcategoryFilter');

    const formfilter = categorySelect.closest('form');
    
    categorySelect.addEventListener('change', function() {
        const categoryId = categorySelect.value;

        fetch(`/filterCategory?category=${categoryId}`)
            .then(response => response.json())
            .then(data => {
                subCategorySelect.innerHTML = '';

                subCategorySelect.disabled = false;

                data.forEach(subCategory => {
                    const option = document.createElement('option');
                    option.value = subCategory.id;
                    option.textContent = subCategory.name;
                    subCategorySelect.appendChild(option);
                });
            })
            .catch(error => console.error('Error', error));
    });


    const cityInput = document.getElementById("cityLocalisation");
    const cityList = document.getElementById("cityList");

    cityInput.addEventListener("input", () =>  {
        if (cityInput.value.length > 2) {
            fetchCities(cityInput.value.trim());
        } else {
            cityList.innerHTML = "";
        }
    });

    const fetchCities = (cityInputText) => {
        fetch(`https://geo.api.gouv.fr/communes?nom=${cityInputText}&fields=nom&boost=population&limit=5`)
            .then(response => response.json())
            .then(data => {
                cityList.innerHTML = "";
                for (let i = 0; i < data.length; i++) {
                    newli = document.createElement("li");
                    newli.innerHTML = data[i].nom;
                    cityList.appendChild(newli);
                    newli.addEventListener("click", () => {
                        cityInput.value = newli.innerHTML;
                        cityList.innerHTML = "";
                    });
                }
            })
            .catch(error => console.error('erreur:', error));
        };


    formfilter.addEventListener('submit', function(event) {
        event.preventDefault(); // Bloquer le rechargement de la page
        event.stopPropagation(); // Empêcher d'autres événements liés

        const formData = new FormData(formfilter);

        const params = new URLSearchParams();

        formData.forEach((value, key) => {
            params.append(key, value);
        });


        const url = new URL (window.location.href);

        fetch(url.pathname + '?' + params.toString(), {
            headers: {
                "X-Requested-With": "XMLHttpRequest"
            }
        }).then(response => response.json())
        .then(data => {
            annonceContainer = document.getElementById('annonceContainer');
            annonceContainer.innerHTML = '';

            data.forEach(annonce => {

                newAnnonce = document.createElement('div');
                newAnnonce.classList.add('mb-2');

                annonceLink = document.createElement('a');
                annonceLink.href = `/annonce/${annonce.id}`;
                annonceLink.classList.add('text-blue-500', 'hover:underline');
                annonceLink.textContent = annonce.title;

                newAnnonce.appendChild(annonceLink);

                annonceImageContainer = document.createElement('div');
                annonceImageContainer.classList.add('mt-2');

                AnnonceImage = document.createElement('img');
                AnnonceImage.src = `/images/placeholder.png`;
                AnnonceImage.alt = annonce.title;
                AnnonceImage.classList.add('w-32', 'h-32', 'object-cover');

                annonceImageContainer.appendChild(AnnonceImage);

                newAnnonce.appendChild(annonceImageContainer);
                annonceContainer.appendChild(newAnnonce);

            });
        })
        .catch(error => console.error('Error', error));
    });

});
