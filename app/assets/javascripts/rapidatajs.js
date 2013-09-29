 $(document).ready(function(){

        var input = localStorage.getItem('myInput');
        $('#search_box').val(input);
        var timeoutReference;
      $('#search_box').keyup(function() {
        
        if (timeoutReference) clearTimeout(timeoutReference);
        timeoutReference = setTimeout(function() {
          var term_val = send_azax_call();
        }, 500);
    });
      $('#tag-cloud').on('click', 'li', function () {
         var abcd = $(this).text();
          var input_value = $('#search_box').val() +" "+ abcd;
          $('#search_box').val(input_value);
          var term_val = send_azax_call();
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
    var fontSize = Math.floor(Math.random() * maxFontSize + 14) + 'px';
    
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

function send_azax_call(){

        var value = $('#search_box').val();
    $.ajax({
         type: "GET",
         url: "http://rapidata-api.herokuapp.com/datasets/retrieve_from_terms.xml",
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
                 // Do something to each item here...
                        var data = $(this).find('title').text();
                        var data1 = $(this).find('description').text();
                        var tags = "";
                        $(this).find('term').each(function(){
                            tags += $(this).text() +"  ";

                        });
                        
                         result += '<div class ="search_head">'+data+"</div>"+
                             '<div class="search_desc">'+data1+"</div>"+
                             '<div class="tag">'+"Related Tags are "+tags+"</div>"+
                             '<div class= "download_links">'+
                                                '<div class="row">'+
                                            '<div class="col-md-4">'+
                                            '</div>'+
                                            '<div class="col-md-2">'+
                                                '<button type="button" class="btn btn-info ">    Download in xml    </button>'+
                                            '</div>'+
                                            '<div class="col-md-2">'+
                                                '<button type="button" class="btn btn-info ">    Download in excel    </button>'+

                                            '</div>'+
                                            '<div class="col-md-4">'+
                                            '</div>'+
                                            '</div>'+
                                            '</div>';
                                         
                             $('#search_result').html(result);
                          i++;
                    });
                        var terms ="";
                        var j = 1;
                    $(xml).find('list_term').each(function() {
                        var term_value = $(this).text();
                        terms += '<li class ="tags_val">'+ term_value+'</li>';

                        if(j%7 == 0)
                        {
                            terms += '<br>';
                        }
                        $('#tag-cloud').html(terms);
                        j++;

                    });
                    $('#tag-cloud li').each(function() {
    
            var $a = $(this);
        var cssColor = createRandomColor();
        var cssFontSize = setFontSize();
        
        var linkOffsets = setOffsets();
        
        
        $a.css({color: cssColor, fontSize: cssFontSize, top: linkOffsets.top, left: linkOffsets.left});
        
    
    });

                    
               
        },
        error: function(){
                alert("Oops!Something went wrong.");
        }

  });

    return value;
}
