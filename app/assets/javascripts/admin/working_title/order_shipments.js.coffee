WorkingTitle.OrderShipments ||=
  initialize: ->
    @selectifyForm()
    @bindHandlers()
    console.log("OrderShipments initialized.")

  selectifyForm: ->
    $(".shipment-package-form select").select2 width: "100%"

  preselectMethod: ($container) ->
    window.$container = $container
    methodId          = $container.data().methodId || null
    $container.find(".shipping-method-column option[value=#{methodId}]").
      last().attr('selected', 'selected')

  handleFieldAdded: (event) ->
    container = $(event.target).parents(".shipment-package-form")
    WorkingTitle.OrderShipments.preselectMethod(container)
    WorkingTitle.OrderShipments.selectifyForm()
    
    # not printable until it's persisted
    $(".icon-print", event.field).hide()

  bindHandlers: ->
    $(document).on "nested:fieldAdded", WorkingTitle.OrderShipments.handleFieldAdded

    # api ship endpoint returns JSON that we don't want to see
    $(".finalize-shipment-button").bind "ajax:success", ->
      location.reload()

    $(".finalize-shipment-button").bind "ajax:failure", ->
      alert "Failed to finalize shipment."

    $(".icon-print").bind "ajax:error", (e, data, status, xhr) ->
      err = JSON.parse(data.responseText).error
      window.errs = err
      err = err or "Unexpected shipping error!  Check server logs for details."
      alert err

    $(".icon-print").bind "ajax:success", (e, data, status, xhr) ->
      location.reload()
