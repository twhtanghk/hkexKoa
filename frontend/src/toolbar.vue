<template>
  <v-app-bar app color='primary'>
    <v-toolbar-title class='white--text'>
      HKEx
    </v-toolbar-title>
    <v-spacer />
    <v-text-field v-model='search' prepend-icon='search' solo clearable hide-details single-line />
  </v-app-bar>
</template>

<script lang='coffee'>
eventBus = require('./eventBus').default

export default
  data: ->
    search: ''
  watch:
    search: (newVal, oldVal) =>
      eventBus.$emit 'search', newVal
</script>
