
# Setup new express application
express = require("express")
http    = require('http')

app     = express()
server  = app.listen(3000)
io      = require('socket.io').listen(server)

app.configure ->
  app.use(express.favicon())
  app.use(express.logger('dev'))
  app.use(express.bodyParser())
  app.use(express.methodOverride())

app.configure('development', ->
  app.use(express.errorHandler())
)

# Set root url
app.get('/', (req, res) ->
  body = 'Luminosity WebSocket Server'
  res.setHeader('Content-Type', 'text/plain')
  res.setHeader('Content-Length', body.length)
  res.end(body)
)

# # Heroku won't actually allow us to use WebSockets
# # so we have to setup polling instead.
# # https://devcenter.heroku.com/articles/using-socket-io-with-node-js-on-heroku
# io.configure ->
#   io.set "transports", ["websocket"]
#   # io.set "transports", ["websocket", "xhr-polling"]
# 
# io.configure ->
#   io.set "transports", ["websocket"]


io.sockets.on "connection", (socket) ->
  
  console.log 'CONNECTION MADE'
  
  # # Prints a list of connected clients
  # console.log "CLIENTS", io.sockets.clients().map((client) -> return client.id)
  
  # Note the use of io.sockets to emit but socket.on to listen
  io.sockets.emit "status",
    status: true
  
  socket.on 'sharing-data', (msg) ->
    socket.broadcast.emit 'request-to-share', msg.filename
  
  socket.on 'translation', (xOffset, yOffset) ->
    socket.broadcast.emit 'translation', xOffset, yOffset
  
  socket.on 'zoom', (zoom) ->
    socket.broadcast.emit 'zoom', zoom
    
  socket.on 'scale', (min, max) ->
    socket.broadcast.emit 'scale', min, max
  
  # Listen for Peer Id
  socket.on 'requestPeerId', (sessionId) ->
    io.sockets.emit 'requestPeerId', sessionId
  
  socket.on 'sendPeerId', (sessionId, peerId) ->
    io.sockets.emit 'sendPeerId',
      sessionId: sessionId
      peerId: peerId

