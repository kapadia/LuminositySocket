
http    = require('http')
express = require("express")
sockets = require('socket.io')

# Setup new express application
app     = express()
server  = http.createServer(app)
io      = sockets.listen(server, {log: false})

# Configuration
app.configure ->
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static("public")

app.configure "development", ->
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )

app.configure "production", ->
  app.use express.errorHandler()


# Set root url
app.get('/', (req, res) ->
  body = 'Luminosity WebSocket Server'
  res.setHeader('Content-Type', 'text/plain')
  res.setHeader('Content-Length', body.length)
  res.end(body)
)

# Heroku won't actually allow us to use WebSockets
# so we have to setup polling instead.
# https://devcenter.heroku.com/articles/using-socket-io-with-node-js-on-heroku
io.configure ->
  io.set "transports", ["websocket"]
  # io.set "transports", ["websocket", "xhr-polling"]


port = process.env.PORT or 5000 # Use the port that Heroku provides or default to 5000
server.listen port, ->
  console.log "Express server listening on port %d in %s mode", port, app.settings.env

# Storage for connected clients

io.sockets.on "connection", (socket) ->
  
  # # Prints a list of connected clients
  # console.log "CLIENTS", io.sockets.clients().map((client) -> return client.id)
  
  # Note the use of io.sockets to emit but socket.on to listen
  io.sockets.emit "status",
    status: true
  
  socket.on 'zoom', (zoom, id) ->
    if zoom?
      io.sockets.emit 'zoom',
        zoom: zoom
        id: id

  socket.on 'translation', (xOffset, yOffset, id) ->
    if xOffset?
      io.sockets.emit 'translation',
        xOffset: xOffset
        yOffset: yOffset
        id: id
  
  # Listen for Peer Id
  socket.on 'requestPeerId', (sessionId) ->
    io.sockets.emit 'requestPeerId', sessionId
  
  socket.on 'sendPeerId', (sessionId, peerId) ->
    io.sockets.emit 'sendPeerId',
      sessionId: sessionId
      peerId: peerId
