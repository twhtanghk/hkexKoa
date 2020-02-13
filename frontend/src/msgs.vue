<template>
  <div>
    <v-list two-line>
      <template v-for="(msg, i) in msgs">
        <v-list-item>
          <v-list-item-avatar>
            <v-icon class="grey white--text">event_note</v-icon>
          </v-list-item-avatar>
          <v-list-item-content>
            <v-list-item-title v-html="title(msg)" />
            <v-list-item-subtitle v-html="subtitle(msg)" />
          </v-list-item-content>
          <v-list-item-action>
            <v-btn icon ripple :href="msg.link" target="_blank">
              <v-icon class="grey white--text">link</v-icon>
            </v-btn>
          </v-list-item-action>
        </v-list-item>
      </template>
    </v-list>
    <div style='text-align: center'>
      <v-progress-circular indeterminate color='primary'
        v-if='! finished'
        v-intersect='next' />
    </div>
  </div>
</template>

<script lang='coffee'>
_ = require 'lodash'
eventBus = require('./eventBus').default
{News} = require('./model').default

export default
  data: ->
    msgs: []
    finished: false
    opts:
      skip: 0
      sort:
        releasedAt: -1
  methods:
    title: (msg) ->
      "<span class='text--primary'>#{msg.code} #{msg.name}</span> #{msg.type} #{msg.typeDetail}"
    subtitle: (msg) ->
      "<span class='text--primary'>#{msg.title}</span> #{new Date(msg.releasedAt).toLocaleString()}"
    next: (entries) ->
      if entries[0].isIntersecting
        @finished = 30 > await @load skip: @msgs.length
    load: (opts) ->
      try
        @opts = _.defaults opts, @opts
        res = await News.get data: @opts
        for i in res
          @msgs.push i
      catch err
        console.error err   
  created: ->
    eventBus
      .$on 'search', (value) =>
        @msgs.splice 0, @msgs.length
        @opts =
          skip: 0
          sort:
            releasedAt: -1
        if value? and value != ''
          pattern = '$regex': value
          @opts = _.extend @opts,
            $or: [
              {code: pattern}
              {name: pattern}
              {type: pattern}
              {typeDetail: pattern}
              {title: pattern}
            ]
        @load @opts
</script>
