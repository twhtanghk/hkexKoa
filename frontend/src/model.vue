<script lang='coffee'>
Vue = require('vue').default
Vue.use require('vue.model/src/plugin').default
{eventBus} = require('jsOAuth2/frontend/src/lib').default

export default
  News: new Vue
    extends: Vue.component 'model'
    props:
      eventBus:
        default: ->
          eventBus
      baseUrl:
        default: "#{process.env.API_URL}/api/news"
</script>
