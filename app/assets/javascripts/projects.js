var markerCount = 0;

function placeMarker() {
  markerCount++;

  Gmaps.map.addMarkers([
      {
        "description": "", 
        "title": "", 
        "sidebar": "", 
        "lng": -70.6157, 
        "lat": -33.4992, 
        "picture": "", 
        "width": "", 
        "height": ""}
        ]);
      };

$('.add_sitio_estudio').on('click', function(){
  placeMarker();
  bindPin(markerCount);
});

// Fuente: https://github.com/nathanvda/cocoon
 $('.study_sites').on('cocoon:after-insert', function(e, insertedItem) {
    // Agregar clase al div de location a partir del contador
    $('.nested-fields:last').find('.toLocate').addClass("location"+markerCount);
    $('.nested-fields:last').attr('id',markerCount);
    //Hacer binding del pin
    bindPinToTextbox(markerCount);  
  });

 $('.study_sites').on('cocoon:after-remove', function(e, insertedItem) {
    Gmaps.map.markers[insertedItem[0].id].serviceObject.setMap(null);
  });

 $('#new_researcher').on('ajax:success', function() {

    $('select[id^="project_researchers"]').append('<option value='+ arguments[1].id + '>' + arguments[1].name + '</option>');

    $('#myModal').foundation('reveal', 'close');
    
})

