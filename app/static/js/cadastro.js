$(document).ready(function () {
    // Mostrar/ocultar campos adicionais com base no tipo de usuário selecionado
    $('#userType').change(function () {
        if ($(this).val() === 'fotografo') {
            $('#additionalFields').show();
        } else {
            $('#additionalFields').hide();
        }
    });
});
