let indiceAtual = 0;
const perfis = document.querySelectorAll('.usuario');
let perfisVisiveis = 6; // Ajuste o número de perfis visíveis conforme desejado

function atualizarPerfisVisiveis() {
    if (window.innerWidth <= 768) {
        perfisVisiveis = 2;
    } else {
        perfisVisiveis = 6; // Ajuste o número de perfis visíveis para telas maiores
    }
}

function mostrarPerfis() {
    perfis.forEach((perfil, i) => {
        if (i >= indiceAtual && i < indiceAtual + perfisVisiveis) {
            perfil.style.display = 'block';
        } else {
            perfil.style.display = 'none';
        }
    });
}

function avancarPerfil() {
    if (indiceAtual + 1 <= perfis.length - perfisVisiveis) {
        indiceAtual += 1;
        mostrarPerfis();
    }
}

function retrocederPerfil() {
    if (indiceAtual > 0) {
        indiceAtual -= 1;
        mostrarPerfis();
    }
}

function iniciarArrastar(e) {
    startX = e.touches ? e.touches[0].clientX : e.clientX;
}

function finalizarArrastar(e) {
    const endX = e.changedTouches ? e.changedTouches[0].clientX : e.clientX;
    const diffX = startX - endX;

    if (diffX > 50) {
        avancarPerfil();
    } else if (diffX < -50) {
        retrocederPerfil();
    }
}

document.addEventListener('mousedown', iniciarArrastar);
document.addEventListener('touchstart', iniciarArrastar);

document.addEventListener('mouseup', finalizarArrastar);
document.addEventListener('touchend', finalizarArrastar);

document.querySelector('#anterior').addEventListener('click', retrocederPerfil);
document.querySelector('#proximo').addEventListener('click', avancarPerfil);

atualizarPerfisVisiveis();
mostrarPerfis();

window.addEventListener('resize', () => {
    atualizarPerfisVisiveis();
    mostrarPerfis();
});
