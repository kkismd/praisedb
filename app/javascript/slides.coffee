# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

slides = -> $('.slide')
current = 0

e = ->
  slides()[current]
p = ->
  $(e())

preElement = ->
  $('.slide pre')[current]

# ページ切り替えのための関数
transition = (callback) ->
  # フェードアウトが終わってから次の手順に移る
  p().animate({opacity:0}, 100, ->
    p().css({display:'none'})
    callback()
    # リサイズのために透明なまま要素を可視状態にする
    p().css({opacity:0, display:'block'})
    resize(e())
    p().animate({opacity:1}, 100)
  )

window.slides_change = (idx) ->
  transition( -> current = idx )

window.slides_prev = ->
  return false if current <= 0
  transition( -> current-- )
  false

window.slides_next = ->
  return false if current >= slides().length - 1
  transition( -> current++ )
  false
