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
{News} = require('./model').default

export default
  data: ->
    msgs: []
    finished: false
  methods:
    title: (msg) ->
      "<span class='text--primary'>#{msg.code} #{msg.name}</span> #{msg.type} #{msg.typeDetail}"
    subtitle: (msg) ->
      "<span class='text--primary'>#{msg.title}</span> #{new Date(msg.releasedAt).toLocaleString()}"
    next: (entries) ->
      if entries[0].isIntersecting
        @finished = 30 > await @load @msgs.length
    load: (skip = 0) ->
      try
        data =
          skip: skip
          sort:
            releasedAt: -1
        res = await News.get data: data
        for i in res
          @msgs.push i
      catch err
        console.error err   
  created: ->
    @load()
</script>
