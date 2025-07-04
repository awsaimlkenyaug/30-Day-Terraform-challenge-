const request = require('supertest');
const app = require('./server');

describe('Application Tests', () => {
  test('GET / returns welcome message', async () => {
    const response = await request(app).get('/');
    expect(response.status).toBe(200);
    expect(response.body.message).toContain('Day 20 Deployment Workflow Demo');
  });

  test('GET /health returns health status', async () => {
    const response = await request(app).get('/health');
    expect(response.status).toBe(200);
    expect(response.body.status).toBe('healthy');
  });
});