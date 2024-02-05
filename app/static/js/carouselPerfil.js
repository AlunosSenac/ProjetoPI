class Carousel {
    constructor(carouselElement) {
        this.indiceAtual = 0;
        this.perfis = carouselElement.querySelectorAll('.usuario');
        this.perfisVisiveis = 6; // Adjust the number of visible profiles as desired

        this.atualizarPerfisVisiveis();
        this.mostrarPerfis();

        
        carouselElement.querySelector('.anterior').addEventListener('click', () => this.retrocederPerfil());
        carouselElement.querySelector('.proximo').addEventListener('click', () => this.avancarPerfil());

        
        document.addEventListener('mousedown', (e) => this.iniciarArrastar(e));
        document.addEventListener('touchstart', (e) => this.iniciarArrastar(e));

        document.addEventListener('mouseup', (e) => this.finalizarArrastar(e));
        document.addEventListener('touchend', (e) => this.finalizarArrastar(e));

      
        window.addEventListener('resize', () => {
            this.atualizarPerfisVisiveis();
            this.mostrarPerfis();
        });
    }

    atualizarPerfisVisiveis() {
        if (window.innerWidth <= 768) {
            this.perfisVisiveis = 2;
        } else {
            this.perfisVisiveis = 6;
        }
    }

    mostrarPerfis() {
        this.perfis.forEach((perfil, i) => {
            if (i >= this.indiceAtual && i < this.indiceAtual + this.perfisVisiveis) {
                perfil.style.display = 'block';
            } else {
                perfil.style.display = 'none';
            }
        });
    }

    avancarPerfil() {
        if (this.indiceAtual + 1 <= this.perfis.length - this.perfisVisiveis) {
            this.indiceAtual += 1;
            this.mostrarPerfis();
        }
    }

    retrocederPerfil() {
        if (this.indiceAtual > 0) {
            this.indiceAtual -= 1;
            this.mostrarPerfis();
        }
    }

    iniciarArrastar(e) {
        this.startX = e.touches ? e.touches[0].clientX : e.clientX;
    }

    finalizarArrastar(e) {
        const endX = e.changedTouches ? e.changedTouches[0].clientX : e.clientX;
        const diffX = this.startX - endX;

        if (diffX > 50) {
            this.avancarPerfil();
        } else if (diffX < -50) {
            this.retrocederPerfil();
        }
    }
}

// Create instances for each carousel on your page
const carousels = document.querySelectorAll('.custom-carousel');
carousels.forEach((carousel) => new Carousel(carousel));
