#!/bin/bash
# Unified Deployment Script
# Version: 3.0.0
# Supports both Production and Development environments

set -e

echo "====================================="
echo "DevOps Simulator - Unified Deployment"
echo "====================================="

# Default to 'development' if no argument is passed
DEPLOY_ENV=${1:-development}

echo "Environment: $DEPLOY_ENV"

# Pre-deployment checks
echo "Running pre-deployment checks..."
if [ ! -f "config/app-config.yaml" ]; then
    echo "Error: Configuration file not found!"
    exit 1
fi

if [ "$DEPLOY_ENV" = "production" ]; then
    echo "====================================="
    echo "Production Deployment"
    echo "====================================="

    DEPLOY_REGION="us-east-1"
    APP_PORT=8080
    ENABLE_DEBUG=false

    echo "Region: $DEPLOY_REGION"
    echo "Port: $APP_PORT"
    echo "Debug: $ENABLE_DEBUG"

    # Deploy application
    echo "Starting production deployment..."
    echo "Pulling latest Docker images..."
    # docker pull devops-simulator:latest

    echo "Rolling update strategy initiated..."
    # kubectl rolling-update devops-simulator

    echo "Deployment completed successfully!"
    echo "Application available at: https://app.example.com"

else
    echo "====================================="
    echo "Development Deployment"
    echo "====================================="

    DEPLOY_MODE="docker-compose"
    APP_PORT=3000
    ENABLE_DEBUG=true

    echo "Mode: $DEPLOY_MODE"
    echo "Port: $APP_PORT"
    echo "Debug: $ENABLE_DEBUG"

    # Install dependencies
    echo "Installing dependencies..."
    npm install

    # Run tests
    echo "Running tests..."
    npm test

    # Deploy application
    echo "Starting development deployment..."
    echo "Using Docker Compose..."
    docker-compose up -d

    # Wait for application to start
    echo "Waiting for application to be ready..."
    sleep 5

    # Health check
    echo "Performing health check..."
    curl -f http://localhost:$APP_PORT/health || exit 1

    echo "Deployment completed successfully!"
    echo "Application available at: http://localhost:$APP_PORT"
    echo "Hot reload enabled - code changes will auto-refresh"
fi
