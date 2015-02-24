# copyright @tinle1201
# wrapper jquery and plugins
define([
  'jquery'
  'foundation'
  'foundation.abide'
], ($)->
	$.abideValidate = ()->
    console.log 'abideValidate'
    setTimeout( ()->
      $(document).foundation
        abide:
          live_validate : true
          validate_on_blur : true
          focus_on_invalid : true
          error_labels: true
          timeout : 1000
    , 2000)  

  return $
)