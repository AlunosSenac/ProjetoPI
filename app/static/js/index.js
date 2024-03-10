document.addEventListener('DOMContentLoaded', function () {
    let carousels = document.getElementsByClassName('carossel-Container');

    for (let i = 0; i < carousels.length; i++) {
        let carousel = carousels[i];
        let btnBack = carousel.querySelector('.BtnBack');
        let btnNext = carousel.querySelector('.BtnNext');
        let items = carousel.querySelectorAll('.item');

        let itemWidth = items[0].offsetWidth;
        let carouselWidth = carousel.offsetWidth;
        let numItems = items.length;
        let totalWidth = itemWidth * numItems;
        let posicaoAnterior = 0;

        // Adiciona uma margem extra no final do contêiner de slides
        carousel.querySelector('.carossel-Slide').style.width = totalWidth + (itemWidth * 0.5) + 'px';

        // Adiciona os eventos de clique para os botões de navegação
        btnNext.addEventListener('click', () => {
            posicaoAnterior += carouselWidth;
            if (posicaoAnterior >= totalWidth) {
                posicaoAnterior = 0;
            }
            carousel.querySelector('.carossel-Slide').style.transform = 'translateX(-' + posicaoAnterior + 'px)';
        });

        btnBack.addEventListener('click', () => {
            posicaoAnterior -= carouselWidth;
            if (posicaoAnterior < 0) {
                posicaoAnterior = totalWidth - carouselWidth;
            }
            carousel.querySelector('.carossel-Slide').style.transform = 'translateX(-' + posicaoAnterior + 'px)';
        });
    }
});
