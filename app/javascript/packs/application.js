// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import 'bootstrap'
import { autosize } from 'autosize'

document.addEventListener("turbolinks:load", () => {
    $('[data-toggle="tooltip"]').tooltip()
    $('[data-toggle="popover"]').popover()

    $(".star-rating").hover(function(e){
        var star = $(this);
        var data_star = star.attr('data-star');
        var car_id = star.attr('data-car_id');
        // Save ratings in database
        if(data_star >= 0){
            $.ajax({
                method:'post',
                url:'/rate_this_seller',
                data: {car_id:car_id,stars:data_star},
                complete: function(data){
                    if(data.status == 200 && (data.responseText == "Updated!" || data.responseText=="Created!")){
                        for(var i=1; i<=5; i++){
                            if(i<=data_star){
                                $('#car_id_'+i).removeClass('fa-star-o');
                                $('#car_id_'+i).addClass('fa-star');
                            }else{
                                $('#car_id_'+i).removeClass('fa-star');
                                $('#car_id_'+i).addClass('fa-star-o');
                            }
                        }
                    }
                }
            });
        }
        // add star in the data page
    });
    
    //add car to favorites
    $('#favorite').click(function(){
        document.getElementById('save_car').click()
    });

    // update car sold status
    $("#mark_as_sold").click(function(){
        var isChecked = $(this).is(":checked");
        var car_id = $(this).data("car_id");
        var value = 0
        if (isChecked == true){
            value = 1
        }
        $.ajax({
            method:'post',
            url:'/mark_as_sold',
            data: {car_id: car_id, sold:value},
            complete: function (data){
            }
        })
    });
})