Spree.ready ($) ->
  if ($ '#checkout_form_payment').is('*')
    $('#apply_coupon_code').click (e) ->
      e.preventDefault()
      # Coupon code application may take a number of seconds.
      # Informing the user that this is happening is a good way to indicate some progress to them.
      # In addition to this, if the coupon code FAILS then they don't lose their just-entered payment data.
      coupon_code_field = $('#order_coupon_code')
      coupon_code = $.trim(coupon_code_field.val())
      if (coupon_code != '')
        if $('#coupon_status').length == 0
          coupon_status = $("<div id='coupon_status'></div>")
          coupon_code_field.parent().append(coupon_status)
        else
          coupon_status = $("#coupon_status")

        url = Spree.url(Spree.routes.apply_coupon_code(Spree.current_order_id),
          {
            order_token: Spree.current_order_token,
            coupon_code: coupon_code
          }
        )

        coupon_status.removeClass();
        $.ajax({
          async: false,
          method: "PUT",
          url: url,
          success: (data) ->
            coupon_code_field.val('')
            coupon_status.addClass("alert-success").html("Coupon code applied successfully.")
            if data.free_order
              $('.payment_block').hide()
              $('#checkout_form_payment').submit()
          error: (xhr) ->
            handler = JSON.parse(xhr.responseText)
            coupon_status.addClass("alert-error").html(handler["error"])
            $('.continue').attr('disabled', false)
            return false
        })
