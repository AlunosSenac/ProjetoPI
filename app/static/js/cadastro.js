$(document).ready(function () {
    // Salve uma referência aos elementos relevantes para melhorar o desempenho
    var userType = $('#userType');
    var additionalFields = $('#additionalFields');

    // Adicione uma classe ao corpo do documento para ajudar a estilização
    userType.change(function () {
        if (userType.val() === 'fotografo') {
            additionalFields.show();
            $('body').addClass('fotografo-selected');
        } else {
            additionalFields.hide();
            $('body').removeClass('fotografo-selected');
        }
    });
});
