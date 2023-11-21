// Inicialize o carrossel Glide.js
  new Glide('.carousel-inner', {
    type: 'carousel',  // Tipo de carrossel
    perView: 4,        // Número de slides visíveis simultaneamente
  }).mount();

  const carousel = document.querySelector('.carousel');
const cards = document.querySelectorAll('.card');
let currentIndex = 0;

function updateCarousel() {
    const cardWidth = cards[0].offsetWidth;
    carousel.style.transform = `translateX(-${currentIndex * cardWidth}px)`;
}

window.addEventListener('resize', updateCarousel);

updateCarousel();

// Função para avançar para o próximo card
function nextCard() {
    currentIndex = Math.min(currentIndex + 1, cards.length - 1);
    updateCarousel();
}

// Função para voltar ao card anterior
function prevCard() {
    currentIndex = Math.max(currentIndex - 1, 0);
    updateCarousel();
}

// Event listeners para os botões de próxima e anterior
document.getElementById('nextBtn').addEventListener('click', nextCard);
document.getElementById('prevBtn').addEventListener('click', prevCard);


