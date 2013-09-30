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
      $('#tag-cloud').on('click', '.tags_val', function () {
         var selected_tag = $(this).text();
          var input_value = $('#search_box').val() +" "+ selected_tag;
          $('#search_box').val(input_value);
          var term_val = send_ajax_call();
      }); 
     $('#clear_last_tag').on('click', function () {
        delete_tag();
        var term_val = send_ajax_call();
      });     
    hide_no_matching_tags_message();
    hide_loader();
});

 function createRandomColor() {  
    var hex = '0123456789ABC'.split(''),  
    color = '#', i;      
    for (i = 0; i < 6; i += 1) {  
        color = color + hex[Math.floor(Math.random() * 13)];  
    } 
    return color;  
}
function delete_tag()
  { 
    var tags = ($('#search_box').val()).split(' '); 
    tags.pop(); 
    $('#search_box').val(tags.join(' ')); 
  }
function hide_loader() { $('#ajax_loader').hide();}
function show_loader() { $('#ajax_loader').show();}
function hide_no_matching_tags_message() { $('#no_matching_tags').hide();}
function show_no_matching_tags_message() { $('#no_matching_tags').show();}
function send_ajax_call(){
    var search_text = $('#search_box').val();
    $.ajax({
      type: "GET",
      url: "datasets/retrieve_from_terms.xml",
      //url:"retrieve_from_terms.json",
      dataType:"xml",
      async:"true",
      data:{"terms":search_text},
      beforeSend: function() { show_loader()},
      success: function (xml) {
        // Process ajax response only if Search Text has not changed
        if (search_text==$('#search_box').val()){
          process_ajax_response(xml);
          hide_loader();
        };
          
        },
        error: function(){
                alert("Oops!Something went wrong.");
                hide_loader();
        }
   });
return search_text;
}
function process_ajax_response(xml)
{
  var result="";
  $("#search_result").html(result);
  $(xml).find('dataset').each(function() {
      // Constructing Search Listings
      var dataset_title = $(this).find('title').text();
      var dataset_description = $(this).find('description').text();
      var link_to_dataset=  $(this).find('link').text();
      var download_link = $(this).find('download_link').text();               
      result += 
         '<div class="search_listing">'
      +     '<a href="http://'+link_to_dataset+'"><div class ="search_head"><u>'+dataset_title+'</u></div></a>'
      +     '<p></p>'
      +     '<div class="search_desc">'+dataset_description+"</div>"
      +     '<div class= "download_links">'
      +        '<div class="row">'
      +            '<div class="col-md-1 download_text">Download:</div>'
      +            '<a href="http://'+download_link+'&format=xls"><div class="col-md-1">'
      +              '<button type="button" class="btn btn-default btn-xs" >XLS</button>'
      +            '</div></a>'
      +            '<a href="http://'+download_link+'&format=xlsx"><div class="col-md-1">'
      +              '<button type="button" class="btn btn-default btn-xs" >XLSX</button>'
      +            '</div></a>'
      +            '<a href="http://'+download_link+'&format=json"><div class="col-md-1">'
      +              '<button type="button" class="btn btn-default btn-xs" >JSON</button>'
      +            '</div></a>'
      +            '<a href="http://'+download_link+'&format=jsonp"><div class="col-md-1">'
      +              '<button type="button" class="btn btn-default btn-xs" >JSONP</button>'
      +            '</div></a>'
      +            '<a href="http://'+download_link+'&format=xml"><div class="col-md-1">'
      +              '<button type="button" class="btn btn-default btn-xs" >XML</button>'
      +            '</div></a>'                
      +            '<div class="col-md-4"></div>'
      +        '</div>'
      +      '</div>'
      + '</div>'
      + '<p></p>';
      $('#search_result').html(result);
        });
      var terms ="";

      // Constructing Tag Cloud
      $(xml).find('list_term').each(function() {
          var term_value = $(this).text();
          terms += '<a href="#"><div class ="tags_val">'+ term_value+'</div></a>';
          $('#tag-cloud').html(terms);
      });

      //Change colour only if terms are changing
      if (terms) 
      {        
        $('#tag-cloud .tags_val').each(function() {
          var $tags_div = $(this);
          var cssColor = createRandomColor();
          $tags_div.css({color: cssColor});
        }); 
      }    
      else
      {
        show_no_matching_tags_message();
      }  
}