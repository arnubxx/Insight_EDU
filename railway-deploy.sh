#!/bin/bash

echo "🚀 Railway Deployment Script for Smart-Edu"

# Run migrations
php artisan migrate --force

# Create storage link
php artisan storage:link

# Cache configuration
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Set permissions
chmod -R 775 storage bootstrap/cache
chmod -R 775 database

echo "✅ Deployment completed successfully!"
