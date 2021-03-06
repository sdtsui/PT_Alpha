define([
  'jq'
  'underscore'
  'Backbone'
  'models/menu_item'
  'views/shared/alert_message'
  'views/shared/tag'
  'text!templates/vendor/menu_items/form.html'
], ($
    _
    Backbone
    MenuItemModel
    AlertMessage
    TagView
    FormMenuItemsTemplate
  )->
    FormMenuItemsView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'
      events:
        'click .deleteMenuItem': 'deleteMenuItem'
        'click .cancelMenuItem': 'cancelMenuItem'
        'click .saveMenuItem': 'saveMenuItem'
        'click .addIngredient': 'addIngredient'
        'click .addPreference': 'addPreference'
        'click .ingredient-tokens .removeTag': 'removeIng'
        'click .preference-tokens .removeTag': 'removePref'

      deleteMenuItem: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()

      addIngredient: (e)->
        that = this
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        args = 
          parent: that
          taggable: 'ingredients'
        @buildTagPanel(args)

      addPreference: (e)->
        that = this
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        args = 
          parent: that
          taggable: 'dietaryPreferences'
        @buildTagPanel(args)

      removeIng: (e)->
        that = this
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        ingredients = that.formItem.get('ingredients') || []
        existed = ingredients.indexOf($e.data('name'))
        console.log existed
        if existed >= 0
          ingredients.splice(existed,1)
        that.formItem.set ingredients: ingredients
        that.$('.ingredient-tokens').html that.buildTagTokensHtml(ingredients)


      removePref: (e)->
        that = this
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        dietaryPreferences = that.formItem.get('dietaryPreferences') || []
        existed = dietaryPreferences.indexOf($e.data('name'))
        if existed >= 0 
          dietaryPreferences.splice(existed,1)
        that.formItem.set dietaryPreferences: dietaryPreferences
        that.$('.preference-tokens').html that.buildTagTokensHtml(dietaryPreferences)


      buildTagPanel: (options)->
        that = this
        view = new TagView(options)
        @$el.append(view.render().el)


      afterAddTag: (options)->
        that = this
        switch options.taggable
          when 'dietaryPreferences'
            dietaryPreferences = that.formItem.get('dietaryPreferences') || []
            if dietaryPreferences.indexOf(options.name) < 0
              dietaryPreferences.push options.name
            that.formItem.set dietaryPreferences: dietaryPreferences
            that.$('.preference-tokens').html that.buildTagTokensHtml(dietaryPreferences)
          when 'ingredients'
            ingredients = that.formItem.get('ingredients') || []
            if ingredients.indexOf(options.name) < 0
              ingredients.push options.name
            that.formItem.set ingredients: ingredients
            that.$('.ingredient-tokens').html that.buildTagTokensHtml(ingredients)

      buildTagTokensHtml: (tags)->
        tpl = """
          <% _.each(tags, function(name){ %>
            <div class="token left">
                <%= name %> &nbsp; <i class="fi-x removeTag" data-name="<%= name %>"></i>
            </div>
          <% }) %>
        """
        html = _.template(tpl, {_: _, tags: tags})
        return html

      cancelMenuItem: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()


      saveMenuItem: (e)->
        that = this
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log @formItem.toJSON()
        isNew = @formItem.isNew()
        if @formItem.isValid()
          if isNew
            @formItem.url = '/api/menu_items/add'
          else
            @formItem.url = '/api/menu_items/update'

          @formItem.save @formItem.toJSON(),
            success: (model, response, options)->
              if isNew
                that.items.add that.formItem
              msg = new AlertMessage({type: 'success', messages: ["Menu item was saved successfully."]})
              that.$el.prepend(msg.render().el)

            error: (model, response, options)->
              console.log 'errror'
              console.log response
              msg = new AlertMessage({messages: ["There are some errors"]})
              that.$el.prepend(msg.render().el)        


      initialize: (options)->
        @formItem = options.formItem
        @items = options.items
        @initConstant()

      initConstant: ()->
        @SUBCATEGORIES =
          "plated" : 'plated'
          "family style" : 'family style'
          "tray passed" : 'tray passed'
          "station" : 'station'
        @PRICE_UNITS =
          A: 'per head'
          B: 'per head per hour'      

      bindingDom: ()->
        @$name = @$('input[name="name"]')
        @$name.on 'blur', => 
          @formItem.set name: @$name.val()

        @$description = @$('textarea[name="description"]')
        @$description.on 'blur', => 
          @formItem.set description: @$description.val()

        @$subcategory = @$('select[name="subcategory"]')
        @$subcategory.on 'blur', => 
          @formItem.set subcategory: @$subcategory.val()       

        @$isActive = @$('input[name="isActive"]')
        @$isActive.on 'click', => 
          @formItem.set isActive: @$isActive.is(':checked')

        @$priceValue = @$('input[name="priceValue"]')
        @$priceValue.on 'blur', => 
          price = @formItem.get('price') || {}
          price.value = @$priceValue.val()
          @formItem.set price: price

        @$priceUnit = @$('select[name="priceUnit"]')
        @$priceUnit.on 'change', => 
          price = @formItem.get('price') || {}
          price.unit = @$priceUnit.val()
          @formItem.set price: price

        @$guestCountRequired = @$('input[name="guestCountRequired"]')
        @$guestCountRequired.on 'click', => 
          guest = @formItem.get('guest') || {}
          guest.countRequired = @$guestCountRequired.is(':checked')
          @formItem.set guest: guest

        @$guestCountValue = @$('input[name="guestCountValue"]')
        @$guestCountValue.on 'blur', => 
          guest = @formItem.get('guest') || {}
          guest.countValue = @$guestCountValue.val()
          @formItem.set guest: guest



      render: ()->
        that = this
        tpl = _.template(FormMenuItemsTemplate, {_: _, item: that.formItem.toJSON(), SUBCATEGORIES: @SUBCATEGORIES, PRICE_UNITS: @PRICE_UNITS})
        @$el.html(tpl)
        @bindingDom()
        @

    )
    return FormMenuItemsView

)