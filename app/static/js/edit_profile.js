document.addEventListener("DOMContentLoaded", function() {
    const sections = document.querySelectorAll(".section");
    const navLinks = document.querySelectorAll("nav ul li a");

    // Function to toggle sections and keep navigation links active
    function toggleSections(targetId) {
        sections.forEach(section => {
            if (section.id === targetId) {
                section.classList.add("active");
            } else {
                section.classList.remove("active");
            }
        });
        navLinks.forEach(link => {
            if (link.getAttribute("href").substring(1) === targetId) {
                link.classList.add("active");
            } else {
                link.classList.remove("active");
            }
        });
    }

    navLinks.forEach(link => {
        link.addEventListener("click", function(event) {
            event.preventDefault();
            const targetId = this.getAttribute("href").substring(1);
            toggleSections(targetId);
        });
    });

    // Initialize the first section and navigation link as active
    const initialSectionId = sections[0].id;
    toggleSections(initialSectionId);
    
    $(document).ready(function(){
        $('#codigo_postal').mask('00000-000');
    });

    // Function to autocomplete CEP using the ViaCEP API
    function autocompleteCEP() {
        var cepInput = document.getElementById('codigo_postal');
        cepInput.addEventListener('input', function() {
            var cep = cepInput.value.replace(/\D/g, '');
            if (cep.length == 8) {
                fetch('https://viacep.com.br/ws/' + cep + '/json/')
                    .then(response => response.json())
                    .then(data => {
                        document.getElementById('cidade').value = data.localidade;
                        document.getElementById('estado').value = data.uf;
                        document.getElementById('pais').value = 'Brasil';
                    })
                    .catch(error => console.error('Erro:', error));
            }
        });
    }

    // Function to autocomplete city and state using the Geonames API
    function autocompleteCityState(countryName) {
        var cityInput = document.getElementById('cidade');
        var stateInput = document.getElementById('estado');
        cityInput.addEventListener('input', function() {
            var cityName = cityInput.value;
            fetch(`http://api.geonames.org/searchJSON?q=${cityName}&country=${countryName}&maxRows=1&username=demo`)
                .then(response => response.json())
                .then(data => {
                    if (data.totalResultsCount > 0) {
                        var city = data.geonames[0];
                        cityInput.value = city.name;
                        stateInput.value = city.adminName1;
                        document.getElementById('pais').value = countryName;
                    }
                })
                .catch(error => console.error('Erro:', error));
        });
    }

    // Function to initialize autocomplete
    function initAutocomplete() {
        autocompleteCEP();
        autocompleteCityState('Brazil'); // For different countries, pass the correct country name
    }

    // Register document loading event and initialize autocomplete
    initAutocomplete();
});
