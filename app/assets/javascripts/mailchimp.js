$(document).ready(function(){
 
  $('form#mcsubscribe')
    .bind("ajax:beforeSend", function(evt, xhr, settings){
      var $divResponse = $('div#response');
 
      $divResponse.data( 'origText', $divResponse.text() );
      $divResponse.text( "Adding Email..." );
 
    })
    .bind("ajax:success", function(evt, data, status, xhr){
      var $form = $(this);
       var $divResponse = $('div#response');
 
      $form.find('input[type="email"]').val("");
      $divResponse.html(data.message);
    })
    .bind('ajax:complete', function(evt, xhr, status){
      var $divResponse = $('div#response');
    })
    .bind("ajax:error", function(evt, xhr, status, error){
       var $divResponse = $('div#response'),
          errors,
          errorText,
      errorList;
 
      try {
        
        errors = $.parseJSON(xhr.responseText);
      } catch(err) {
        
        errors = {message: "Please reload the page and try again"};
      }
 
      
      errorText = "There were errors with the submission. Please reload the page and try again.";
      errorList = "<ul>"
      for ( error in errors ) {
        errorList += "<li>" + error + ': ' + errors[error] + "</li> ";
      }
 
      errorList += "</ul>";
 
      
      $divResponse.html(errorText);
    });
 
});