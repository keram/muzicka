$(function () {
    var iframes = $('#page iframe');
    $('#menu').on('mouseover', function () {
        iframes.css({'visibility': 'hidden'});
    }).on('mouseout', function () {
        iframes.css({'visibility': 'visible'});
    });
});