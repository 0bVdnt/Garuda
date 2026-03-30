const io = require('socket.io-client')

const SERVER_URL = process.env.REACT_APP_SERVER_URL || window.location.origin
const socket = io.connect(SERVER_URL)
socket.on('connect', () => {
    
})

export default socket
