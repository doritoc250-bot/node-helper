import express from 'express';
import { createServer } from 'http';
import { WebSocketServer } from 'ws';
import { fileURLToPath } from 'url';
import { join, dirname } from 'path';

const __dirname = dirname(fileURLToPath(import.meta.url));
const app = express();
const server = createServer(app);

app.use(express.static(join(__dirname, 'public')));
app.use('/uv/', express.static(join(__dirname, 'public/uv')));

app.use((req, res) => res.status(404).send('Not found'));

const wss = new WebSocketServer({ server, path: '/wisp/' });
wss.on('connection', (ws) => ws.on('error', console.error));

const port = parseInt(process.env.PORT || '8080');
server.listen(port, '0.0.0.0', () => {
  console.log(`Running on port ${port}`);
  setInterval(async () => {
    try { await fetch(`http://localhost:${port}`); } catch(e) {}
  }, 4 * 60 * 1000);
});
