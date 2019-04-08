<template>
  <v-app>
    <toolbar />
    <alert />
    <msgs />
  </v-app>
</template>

<script lang='coffee'>
Vue = require('vue').default
Vue.use require 'vuetify'

export default
  name: 'app'
  components:
    toolbar: require('./toolbar').default
    alert: require('jsOAuth2/frontend/src/alert').default
    msgs: require('./msgs').default
</script>

<style lang='scss'>
@import url('https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons');
@import '~vuetify/dist/vuetify.min.css';

#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
