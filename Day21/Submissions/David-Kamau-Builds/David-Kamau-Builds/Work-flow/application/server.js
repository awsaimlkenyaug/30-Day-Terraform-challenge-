const express = require('express');
const helmet = require('helmet');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(helmet());
app.use(express.json());

app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    version: '1.2.3'
  });
});

app.get('/', (req, res) => {
  res.json({
    message: 'Day 20 Deployment Workflow Demo',
    environment: process.env.NODE_ENV || 'development',
    server: require('os').hostname()
  });
});

if (require.main === module) {
  app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
  });
}

module.exports = app;