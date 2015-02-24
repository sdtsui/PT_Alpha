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
        # 'click .deleteRoom': 'deleteRoom'

      cancelRoom: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()


      saveRoom: (e)->
        that = this
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log @formRoom.toJSON()

        isNew = @formRoom.isNew()
        if isNew
          @formRoom.url = '/api/rooms/add'
        else
          @formRoom.url = '/api/rooms/update'

        @formRoom.save @formRoom.toJSON(),
          success: (model, response, options)->
            if isNew
              that.rooms.add that.formRoom
            msg = new AlertMessage({type: 'success', messages: ["Room was saved successfully."]})
            that.$el.prepend(msg.render().el)

          error: (model, response, options)->
            console.log 'errror'
            console.log response
            msg = new AlertMessage({messages: ["There are some errors"]})
            that.$el.prepend(msg.render().el)        

      deleteRoom: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()


      initialize: (options)->
        @room = options.room
        @rooms = options.rooms
        @formRoom = @room
        console.log @room
        @initConstant()

      initConstant: ()->
        @ROOM_TYPES =
          private: 'private'
          public: 'public'
          semiprivate: 'semi-private'

        @HOUSE_RULES =
          pacific: "Pacific Standard Time"
          easter: "Eastern Standard Time"
          central: "Central Standard Time"

        @CANCELLATIONS =
          pacific: "Pacific Standard Time"
          easter: "Eastern Standard Time"
          central: "Central Standard Time"

        @LEAD_TIMES =
          3: '3 days'
          7: '1 week'
          14: '2 weeks'

        @OVERAGE_UNITS =
          30: 'every 30 minutes'
          60: 'every 60 minutes'      

        @ROOM_SIZE_UNITS =
          sf: 'square feet'
          sm: 'square meters'
           
      bindingDom: ()->
        @$name = @$('input[name="name"]')
        @$name.on 'blur', => 
          @formRoom.set name: @$name.val()

        @$roomType = @$('select[name="roomType"]')
        @$roomType.on 'change', => 
          @formRoom.set roomType: @$roomType.val()

        @$roomSizeValue = @$('input[name="roomSizeValue"]')
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
        tpl = _.template(RoomGeneralTemplate,
          _: _
          room: @room.toJSON()
          ROOM_TYPES: @ROOM_TYPES
          HOUSE_RULES: @HOUSE_RULES
          CANCELLATIONS: @CANCELLATIONS
          LEAD_TIMES: @LEAD_TIMES
          OVERAGE_UNITS: @OVERAGE_UNITS
          ROOM_SIZE_UNITS: @ROOM_SIZE_UNITS
        )
        @$el.html(tpl)
        @bindingDom()
        $.abideValidate()
        @

    )
    return RoomGeneralView

)      