const jsonServer = require('json-server')

// Returns an Express server
const server = jsonServer.create()

// Set default middlewares (logger, static, cors and no-cache)
server.use(jsonServer.defaults())

const router = jsonServer.router('db.json')

server.use(router)
server.listen(4000)

console.log('Listening at 4000')
