const http = require('http');

const PORT = process.env.PORT || 3000;

const HTML = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>CloudScale – Final Project</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Segoe UI', sans-serif;
      background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #fff;
    }
    .card {
      background: rgba(255,255,255,0.08);
      border: 1px solid rgba(255,255,255,0.15);
      border-radius: 16px;
      padding: 48px 56px;
      max-width: 620px;
      text-align: center;
      backdrop-filter: blur(10px);
    }
    .badge {
      display: inline-block;
      background: #00c6ff;
      color: #0f2027;
      font-size: 12px;
      font-weight: 700;
      letter-spacing: 1px;
      text-transform: uppercase;
      padding: 4px 14px;
      border-radius: 99px;
      margin-bottom: 24px;
    }
    h1 { font-size: 2.2rem; margin-bottom: 12px; }
    .name { color: #00c6ff; font-size: 1.4rem; margin: 16px 0 8px; font-weight: 600; }
    p { color: rgba(255,255,255,0.7); line-height: 1.7; margin-bottom: 8px; }
    .stack { margin-top: 28px; display: flex; justify-content: center; gap: 12px; flex-wrap: wrap; }
    .tag {
      background: rgba(0,198,255,0.15);
      border: 1px solid rgba(0,198,255,0.4);
      padding: 6px 16px;
      border-radius: 99px;
      font-size: 13px;
      color: #00c6ff;
    }
    .footer { margin-top: 32px; font-size: 13px; color: rgba(255,255,255,0.4); }
  </style>
</head>
<body>
  <div class="card">
    <span class="badge">CloudScale · Final Project</span>
    <h1>☸️ Kubernetes Deployment</h1>
    <div class="name">Deployed by: Ayoub, Mohamed, Mohamed, Abdullah, and Anas</div>
    <p>Running on <strong>Azure Kubernetes Service (AKS)</strong> with image stored in <strong>Azure Container Registry (ACR)</strong>.</p>
    <p>Infrastructure provisioned with <strong>Terraform</strong>, automated via <strong>GitHub Actions</strong>.</p>
    <div class="stack">
      <span class="tag">Docker</span>
      <span class="tag">ACR</span>
      <span class="tag">Terraform</span>
      <span class="tag">AKS</span>
      <span class="tag">Kubernetes</span>
      <span class="tag">GitHub Actions</span>
    </div>
    <div class="footer">Cloud Computing &amp; DevOps Engineering · 2026 | Served at: ${new Date().toLocaleString()}</div>
  </div>
</body>
</html>`;

const server = http.createServer((req, res) => {
  // Health endpoint for Kubernetes probes
  if (req.url === '/health') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'healthy', timestamp: new Date().toISOString() }));
    return;
  }

  // Main page
  res.writeHead(200, { 'Content-Type': 'text/html' });
  res.end(HTML);
});

server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  console.log(`Health endpoint: http://localhost:${PORT}/health`);
});
