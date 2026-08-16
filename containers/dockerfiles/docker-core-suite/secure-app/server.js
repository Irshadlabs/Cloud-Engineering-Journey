const http = require('http');
const server = http.createServer((req, res) => {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: "healthy", engine: "Docker Secure Layer" }));
});
server.listen(8080, () => console.log('Enterprise service bound to port 8080'));
