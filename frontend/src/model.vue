<script lang='coffee'>
Vue = require('vue').default
Vue.use require('vue.model/src/plugin').default
{eventBus} = require('jsOAuth2/frontend/src/lib').default
{parse, format} = require 'url'

export default
  News: new Vue
    extends: Vue.component 'model'
    props:
      eventBus:
        default: ->
          eventBus
      baseUrl:
        default: "#{process.env.API_URL}/api/news"
    methods:
      format: (data) ->
        url = parse process.env.HKEX_URL
        url.pathname = data.link
        data.link = format url
        data
</script>
