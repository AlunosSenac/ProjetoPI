document.addEventListener("DOMContentLoaded", function() {
  var imgtexts = document.querySelectorAll("[id^='imgtext']");
  var imganis = document.querySelectorAll("[id^='imgani']");
  var animationCount = 0;

  function isElementInViewport(element) {
    var rect = element.getBoundingClientRect();
    var windowHeight = window.innerHeight || document.documentElement.clientHeight;
    var windowWidth = window.innerWidth || document.documentElement.clientWidth;

    var vertInView = (rect.top <= (windowHeight - rect.height * 0.3)) && ((rect.top + rect.height * 0.7) >= 0.3 * windowHeight);
    var horInView = (rect.left <= windowWidth) && ((rect.left + rect.width) >= 0);

    return (vertInView && horInView);
  }

  function animateImgText() {
    imgtexts.forEach(function(imgtext, index) {
      if (isElementInViewport(imgtext)) {
        imgtext.style.opacity = "1"; // Mostrar o conteúdo
        imganis[index].classList.add("animate-left"); // Adicionar a classe de animação à imagem correspondente
        
        var textElements = imgtext.querySelectorAll(".animate-right");
        textElements.forEach(function(text, textIndex) {
          if (!text.classList.contains("animated")) {
            text.style.opacity = "0";
            text.style.animationDelay = (textIndex * 0.2) + "s";
            text.classList.add("animated");
          }
        });
      } else {
        imgtext.style.opacity = "0"; // Esconder o conteúdo
        imganis[index].classList.remove("animate-left"); // Remover a classe de animação da imagem correspondente
        
        var textElements = imgtext.querySelectorAll(".animate-right");
        textElements.forEach(function(text) {
          text.style.opacity = "0";
          text.classList.remove("animated");
        });
      }
    });
  }

  function startAnimation() {
    animateImgText();
    animationCount++;

    if (animationCount < 5) {
      setTimeout(startAnimation, 5000); // Esperar 5 segundos antes de iniciar a próxima animação
    }
  }

  window.addEventListener("scroll", function() {
    animateImgText();
    animationCount = 0; // Reiniciar o contador para repetir a animação a cada rolagem
  });

  startAnimation(); // Iniciar o loop de animação no carregamento da página
});
