$(function () {
    $(document).ready(function () {
        // Retrieve the most current moisture level reported by the server
        var moistureLevel = $('#moistureLevel').val();

        var endpointUrl = 'https://plantsdb.xyz/search';
        var params = {
            limit: '10',
            fields: 'Genus,Species,AcceptedSymbol,Common_Name,Moisture_Use,pH_Minimum,pH_Maximum',
            Moisture_Use: moistureLevel
        };
        $.get(endpointUrl, params, function (data, status) {
            console.log(status);
            console.log(data);
            var listItems = [];
            $.each(data.data, function (i, item) {
                listItems.push('<li><span class="mdl-checkbox__label">' + item.Common_Name + '</span></li>');
            });
            $('#recommendedPlants').append(listItems.join(''));
        });
    });
});