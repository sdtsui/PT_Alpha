define([
  'jq'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'text!templates/vendor/rooms/general.html'
], ($
    _
    Backbone
    AlertMessage
    RoomGeneralTemplate
  )->
    RoomGeneralView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'

      events:
        'click .cancelRoom': 'cancelRoom'
        'click .saveRoom': 'saveRoom'
        'click .deleteRoom': 'deleteRoom'

      cancelRoom: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()


      saveRoom: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log @formRoom.toJSON()

      deleteRoom: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()


      initialize: (options)->
        @room = options.room
        @formRoom = @room
        console.log @room

      bindingDom: ()->
        @$name = @$('input[name="name"]')
        @$name.on 'blur', => 
          @formRoom.set name: @$name.val()

        @$roomType = @$('input[name="roomType"]')
        @$roomType.on 'change', => 
          @formRoom.set roomType: @$roomType.val()

        @$roomSizeValue = @$('select[name="roomSizeValue"]')
        @$roomSizeValue.on 'change', => 
          roomSize = @formRoom.get('roomSize') || {}
          roomSize.value = @$roomSizeValue.val()
          @formRoom.set roomSize: roomSize

        @$roomSizeUnit = @$('select[name="roomSizeUnit"]')
        @$roomSizeUnit.on 'change', => 
          roomSize = @formRoom.get('roomSize') || {}
          roomSize.unit = @$roomSizeUnit.val()
          @formRoom.set roomSize: roomSize

        @$description = @$('textarea[name="description"]')
        @$description.on 'blur', => 
          @formRoom.set description: @$description.val()


        @$isActive = @$('input[name="isActive"]')
        @$isActive.on 'click', => 
          @formRoom.set isActive: @$isActive.is(':checked')

        @$requireApproval = @$('input[name="requireApproval"]')
        @$requireApproval.on 'click', => 
          @formRoom.set requireApproval: @$requireApproval.is(':checked')

        @$revenueOn = @$('input[name="revenueOn"]')
        @$revenueOn.on 'click', => 
          @formRoom.set revenueOn: @$revenueOn.is(':checked')

        @$rateDay = @$('input[name="rateDay"]')
        @$rateDay.on 'change', => 
          rate = @formRoom.get('rate') || {}
          rate.day = @$rateDay.val()
          @formRoom.set rate: rate
        @$rateNight = @$('input[name="rateNight"]')
        @$rateNight.on 'change', => 
          rate = @formRoom.get('rate') || {}
          rate.night = @$rateNight.val()
          @formRoom.set rate: rate

        @$feeRental = @$('input[name="feeRental"]')
        @$feeRental.on 'change', => 
          fee = @formRoom.get('fee') || {}
          fee.rental = @$feeRental.val()
          @formRoom.set fee: fee
        @$feeCleaning = @$('input[name="feeCleaning"]')
        @$feeCleaning.on 'change', => 
          fee = @formRoom.get('fee') || {}
          fee.cleaning = @$feeCleaning.val()
          @formRoom.set fee: fee

        @$overageValue = @$('input[name="overageValue"]')
        @$overageValue.on 'change', => 
          overage = @formRoom.get('overage') || {}
          overage.value = @$overageValue.val()
          @formRoom.set overage: overage
        @$overageUnit = @$('select[name="overageUnit"]')
        @$overageUnit.on 'change', => 
          overage = @formRoom.get('overage') || {}
          overage.unit = @$overageUnit.val()
          @formRoom.set overage: overage

        @$houseRule = @$('select[name="houseRule"]')
        @$houseRule.on 'change', => 
          @formRoom.set houseRule: @$houseRule.val()
          
        @$cancelPolicy = @$('select[name="cancelPolicy"]')
        @$cancelPolicy.on 'change', => 
          @formRoom.set cancelPolicy: @$cancelPolicy.val()
          
        @$leadTime = @$('select[name="leadTime"]')
        @$leadTime.on 'change', => 
          @formRoom.set leadTime: @$leadTime.val()


      render: ()->
        that = this
        tpl = _.template(RoomGeneralTemplate, {_: _, room: @room.toJSON() })
        @$el.html(tpl)
        @bindingDom()
        @

    )
    return RoomGeneralView

)      