document.addEventListener('DOMContentLoaded', function() {

    // recupération de l'élement select de la categorie
    const categoryElement = document.getElementById('annonce_Category');

    // ecoute de levenement sur le chagement de la categorie
    categoryElement.addEventListener('change', function(e) {
        // recuperation du formulaire a partir de l'element select categorie
        const formElement = categoryElement.closest('form');

        // envoi de la requete a partir des données du formulaire (method et action)
        fetch(formElement.action, {
            method: formElement.method,
            body: new FormData(formElement)
        })
        .then(response => response.text())
        .then(html => {
            // recuperation de l'element select de la sous-categorie du formulaire
            const parser = new DOMParser();
            const doc = parser.parseFromString(html, 'text/html');
            const newSubCategoryElement = doc.getElementById('annonce_subcategory');

            // remplacement du select de la sous-categorie par le nouveau select
            document.getElementById('annonce_subcategory').replaceWith(newSubCategoryElement);
        })
        // recuperation de l'erreur de la requete
        .catch(function (error) {
            console.warn('Un problème est survenue.', error);
        });
    });
});