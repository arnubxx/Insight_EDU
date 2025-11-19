#!/bin/bash

echo "🚂 Railway Deployment Helper for Smart-Edu"
echo "=========================================="
echo ""

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "📦 Railway CLI not found. Installing..."
    npm install -g @railway/cli
    echo "✅ Railway CLI installed!"
    echo ""
else
    echo "✅ Railway CLI already installed"
    echo ""
fi

# Check if user is logged in
echo "🔐 Logging into Railway..."
echo "   A browser window will open for authentication"
railway login

echo ""
echo "🔗 Linking to Railway project..."
echo "   Select your Smart-Edu project from the list"
railway link

echo ""
echo "🎯 What would you like to do?"
echo ""
echo "1) Generate APP_KEY"
echo "2) Run migrations"
echo "3) Deploy application"
echo "4) View logs"
echo "5) Open app in browser"
echo "6) View environment variables"
echo "7) Full setup (APP_KEY + migrations + deploy)"
echo "8) Exit"
echo ""
read -p "Enter your choice (1-8): " choice

case $choice in
    1)
        echo "🔑 Generating APP_KEY..."
        railway run php artisan key:generate
        echo "✅ APP_KEY generated and added to Railway!"
        ;;
    2)
        echo "🗄️  Running migrations..."
        railway run php artisan migrate --force
        railway run php artisan storage:link
        echo "✅ Migrations completed!"
        ;;
    3)
        echo "🚀 Deploying application..."
        railway up
        echo "✅ Deployment triggered!"
        ;;
    4)
        echo "📋 Viewing logs..."
        railway logs
        ;;
    5)
        echo "🌐 Opening app in browser..."
        railway open
        ;;
    6)
        echo "🔧 Environment variables:"
        railway variables
        ;;
    7)
        echo "🎯 Running full setup..."
        echo ""
        echo "Step 1: Generating APP_KEY..."
        railway run php artisan key:generate
        echo ""
        echo "Step 2: Running migrations..."
        railway run php artisan migrate --force
        echo ""
        echo "Step 3: Creating storage link..."
        railway run php artisan storage:link
        echo ""
        echo "Step 4: Deploying application..."
        railway up
        echo ""
        echo "✅ Full setup completed!"
        echo ""
        echo "🌐 Opening your app..."
        railway open
        ;;
    8)
        echo "👋 Goodbye!"
        exit 0
        ;;
    *)
        echo "❌ Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "✨ Done!"
