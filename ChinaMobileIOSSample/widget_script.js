const bindEvent = (element, eventName, eventHandler) => {
    if (element.addEventListener) {
        element.addEventListener(eventName, eventHandler, false)
    } else if (element.attachEvent) {
        element.attachEvent('on' + eventName, eventHandler)
    }
}

// get from widget
bindEvent(window, 'message', (event) => {
  const { origin, data } = event
  if (data && data.length) {
    try {
      const { type } = JSON.parse(data)
      if (type === 'loaded') {
        window.webViewBridge.setEnv('iOS')
        const initialize = {
          type: 'initialize',
          provider_id: 13
        }
        window.webViewBridge.send(initialize)
        const message = { type: 'loaded' }
        window.webkit.messageHandlers.send.postMessage(JSON.stringify(message))
      }
    } catch (e) {
    console.log(`caught error in container: ${e}`)
    }
  }
})

