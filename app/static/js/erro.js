// Seleciona o formulário de login
var loginForm = document.querySelector('.login-form');

// Adiciona a classe de erro ao formulário
loginForm.classList.add('error');

// Remove a classe de erro após 4 segundos
setTimeout(function() {
    loginForm.classList.remove('error');
}, 4000); // 4000 milissegundos = 4 segundos
