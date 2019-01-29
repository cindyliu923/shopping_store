// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require jquery_ujs
//= require bootstrap-sprockets

$(document).on("turbolinks:load", function() {

  function setTotal(){
    var subtotal = 0
    $(".cart-item").each(function(){
      var  quantity  =  parseInt ($(this).find(".quantity").html());
      var  price  =  parseInt ($(this).find(".price").text().replace("$", ''));
      subtotal += ( price * quantity );
    })
    $(".subtotal").find(".amount").html("$"+subtotal);
  }

  $(".add-product").on("click", function(event) {
    event.preventDefault();
    var id = event.target.parentNode.id;

    $.ajax({
      url: "/products/" + id + "/add_product_to_cart",
      method: "POST",
      dataType: "json",
      success: function(data) {
        var item = document.createElement("div");
        item.id = data["id"];

        var quantity =(( $(".cart-item-"+id).find(".quantity").html() ) || 1);
        if ( $("#item").find(".cart-item-"+id).length ) {
          quantity ++;
          $(".cart-item-"+id).find(".quantity").html(quantity);
        } else {
          item.className = "cart-item-"+id;
          $(item).html($("#item-template").html());
          $(item).find("img").attr("src",data["image"]);
          $(item).find(".price").html("$"+data["price"]);
          $(item).find(".name").html(data["name"]);
          $("#item").find("#item-list").append(item);
          $(".cart-item-"+id).find(".quantity").html(quantity);
        }
          setTotal();
        }
      });
    });

  $("#my-cart").on("click", ".delete-item", function(event) {
    var id = event.target.parentNode.parentNode.parentNode.parentNode.id;
    $.ajax({
      url: "/products/" + id + "/remove_from_cart",
      method: "POST",
      dataType: "json",
      success: function(data) {
        $("#item").find(".cart-item-" + data["id"]).remove();
        setTotal();
      }
    });
  });

  $("#item-list").on("click", ".add", function(event) {
    var id = event.target.parentNode.parentNode.parentNode.parentNode.parentNode.id;
    $.ajax({
      url: "/products/" + id + "/add_cart_item_quantity",
      method: "POST",
      dataType: "json",
      success: function(data) {
        var quantity = $(".cart-item-"+id).find(".quantity").html();
        quantity ++;
        $(".cart-item-"+id).find(".quantity").html(quantity);
        var price  =  parseInt ($(".cart-item-"+id).find(".price").text().replace("$", ''));
        var total = price * quantity;
        $(".cart-item-"+id).find(".item-total").html("$"+total);
        setTotal();
      }
    });
  });

  $("#item-list").on("click", ".minus", function(event) {
    var id = event.target.parentNode.parentNode.parentNode.parentNode.parentNode.id;
    $.ajax({
      url: "/products/" + id + "/minus_cart_item_quantity",
      method: "POST",
      dataType: "json",
      success: function(data) {
        var quantity = $(".cart-item-"+id).find(".quantity").html();
        if(quantity > 1){
          quantity --;
          $(".cart-item-"+id).find(".quantity").html(quantity);
          var price  =  parseInt ($(".cart-item-"+id).find(".price").text().replace("$", ''));
          var total = price * quantity;
          $(".cart-item-"+id).find(".item-total").html("$"+total);
          setTotal();
        }
      }
    });
  });

});
