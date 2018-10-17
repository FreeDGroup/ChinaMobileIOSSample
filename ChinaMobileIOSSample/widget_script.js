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
        const initialize = {
          type: 'initialize',
          useEnv: 'iOS',
          openWidget: true,
          provider_id: 12
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

