 $(document).ready(function(){
      var input = localStorage.getItem('myInput');
      $('#search_box').val(input);
      var timeoutReference;
      $('#search_box').keyup(function() {
        if (timeoutReference) clearTimeout(timeoutReference);
        timeoutReference = setTimeout(function() {
          var term_val = send_ajax_call();
        }, 500);
    });
      $('#tag-cloud').on('click', 'div', function () {
         var selected_tag = $(this).text();
          var input_value = $('#search_box').val() +" "+ selected_tag;
          $('#search_box').val(input_value);
          var term_val = send_ajax_call();
      });    
});
 function createRandomColor() {  
    var hex = '0123456789ABC'.split(''),  
    color = '#', i;      
    for (i = 0; i < 6; i += 1) {  
        color = color + hex[Math.floor(Math.random() * 13)];  
    } 
    return color;  
}
function setFontSize() {
    var maxFontSize = 27;
    var fontSize = Math.floor(Math.random() * maxFontSize + 20) + 'px';    
    return fontSize;
}
function setOffsets() {
  var offsets = {};  
  var randTop = Math.floor(Math.random() * 10);
  var randLeft = Math.floor(Math.random() * 10);  
  var maxTop = Math.floor(Math.random() * randTop) + 'px';
  var maxLeft = Math.floor(Math.random() * randLeft) + 'px';
  offsets.top = maxTop;
  offsets.left = maxLeft;   
  return offsets;    
}
function send_ajax_call(){
    var value = $('#search_box').val();
    $.ajax({
      type: "GET",
      url: "datasets/retrieve_from_terms.xml",
      //url:"retrieve_from_terms.json",
      dataType:"xml",
      async:"true",
      data:{"terms":value},
      success: function (xml) {
          // Parse the xml file and get data
          var result="";
          $("#search_result").html(result);
          var i=1;
          $(xml).find('dataset').each(function() {
           // Constructing Search Listings
                var dataset_title = $(this).find('title').text();
                var dataset_description = $(this).find('description').text();                 
                result += 
                   '<div class="search_listing">'
                +     '<div class ="search_head">'+dataset_title+"</div>"
                +     '<div class="search_desc">'+dataset_description+"</div>"
                +     '<div class= "download_links">'
                +        '<div class="row">'
                +            '<div class="col-md-4"></div>'
                +            '<div class="col-md-2">'
                +              '<button type="button" class="btn btn-info ">    Download in xml    </button>'
                +            '</div>'
                +            '<div class="col-md-2">'
                +              '<button type="button" class="btn btn-info ">    Download in excel    </button>'
                +            '</div>'
                +            '<div class="col-md-4"></div>'
                +        '</div>'
                +      '</div>'
                + '</div>';
                                 
                     $('#search_result').html(result);
                  i++;
              });
              var terms ="";
              // Constructing Tag Cloud
              $(xml).find('list_term').each(function() {
                  var term_value = $(this).text();
                  terms += '<a href="#"><div class ="tags_val">'+ term_value+'</div></a>';
                  $('#tag-cloud').html(terms);
              });
              $('#tag-cloud .tags_val').each(function() {
                var $tags_div = $(this);
                var cssColor = createRandomColor();
                var cssFontSize = setFontSize();
                var linkOffsets = setOffsets();
                $tags_div.css({color: cssColor});
              }); 
             $('#tag-cloud').css('height',$('.tags_val').height()*4);

        },
        error: function(){
                alert("Oops!Something went wrong.");
        }
  });
return value;
}
