/**
 * System Monitoring Script - Unified
 * Supports both Production and Development environments
 */

const ENV = process.env.NODE_ENV || 'development';

console.log('=================================');
console.log(`DevOps Simulator - Monitor (${ENV.toUpperCase()})`);
console.log('=================================');

const monitorConfig = {
  production: {
    interval: 60000, // 1 minute
    alertThreshold: 80,
    metricsEndpoint: 'http://localhost:8080/metrics',
    debugMode: false
  },
  development: {
    interval: 30000, // 30 seconds
    alertThreshold: 90,
    metricsEndpoint: 'http://localhost:3000/metrics',
    debugMode: true
  }
}[ENV];

function checkSystemHealth() {
  console.log(`[${new Date().toISOString()}] Checking system health...`);

  // Simulated checks
  console.log('✓ CPU usage: Normal');
  console.log('✓ Memory usage: Normal');
  console.log('✓ Disk space: Adequate');

  console.log(`System Status: HEALTHY (${ENV.toUpperCase()})`);
}

// Start monitoring
console.log(`Monitoring every ${monitorConfig.interval}ms`);
setInterval(checkSystemHealth, monitorConfig.interval);

// Run first check immediately
checkSystemHealth();

// Development-only features
if (monitorConfig.debugMode) {
  console.log('Debug features enabled (Development Mode)');
  setInterval(() => {
    const memUsage = process.memoryUsage();
    console.log('\n--- Memory Usage ---');
    console.log(`RSS: ${(memUsage.rss / 1024 / 1024).toFixed(2)} MB`);
    console.log(`Heap Used: ${(memUsage.heapUsed / 1024 / 1024).toFixed(2)} MB`);
  }, 30000);
}
