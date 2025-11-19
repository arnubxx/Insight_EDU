# 🚀 Quick Railway Deployment Steps

## ✅ What's Already Done
- ✅ Dockerfile created
- ✅ Nginx configuration added
- ✅ Railway deployment files created
- ✅ Committed and pushed to GitHub

## 📋 Next Steps (Follow in Order)

### 1. Sign Up for Railway
- Go to: https://railway.app
- Click "Login with GitHub"
- Authorize Railway to access your repositories

### 2. Create New Project
- Click "Start a New Project"
- Select "Deploy from GitHub repo"
- Choose: `0xzahed/Smart-Edu`
- Click "Deploy Now"

### 3. Wait for Initial Build (2-5 minutes)
Railway will automatically:
- Detect Laravel project
- Build using Dockerfile
- Deploy application

### 4. Generate Domain
- Go to Settings → Networking
- Click "Generate Domain"
- You'll get: `smart-edu-production.up.railway.app`
- **Copy this URL!**

### 5. Set Environment Variables
Click "Variables" tab, then "Raw Editor", paste this:

```env
APP_NAME=Smart Edu
APP_ENV=production
APP_DEBUG=false
APP_URL=https://smart-edu-production.up.railway.app
LOG_LEVEL=error

DB_CONNECTION=sqlite
DB_DATABASE=/var/www/database/database.sqlite

SESSION_DRIVER=database
SESSION_LIFETIME=120
CACHE_STORE=database
QUEUE_CONNECTION=database

MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-gmail-app-password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=your-email@gmail.com
MAIL_FROM_NAME=Smart Edu

GOOGLE_DRIVE_CLIENT_ID=
GOOGLE_DRIVE_CLIENT_SECRET=
GOOGLE_DRIVE_REFRESH_TOKEN=
GOOGLE_DRIVE_FOLDER_ID=
```

**Replace:**
- `smart-edu-production.up.railway.app` with YOUR actual Railway domain
- Gmail credentials (get app password from Google Account settings)
- Google Drive credentials (from your Google Cloud Console)

### 6. Generate APP_KEY

**Method 1 - Using Railway CLI (Recommended):**
```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Link to your project
railway link

# Generate key
railway run php artisan key:generate

# This automatically adds APP_KEY to your environment variables
```

**Method 2 - Manually:**
```bash
# Run locally
php artisan key:generate --show

# Copy the output (looks like: base64:xxxxxxxxxxxx)
# Add it to Railway Variables as APP_KEY
```

### 7. Run Database Migrations

```bash
# Using Railway CLI
railway run php artisan migrate --force

# Optional: Seed database
railway run php artisan db:seed --force
```

### 8. Create Storage Link

```bash
railway run php artisan storage:link
```

### 9. Test Your Deployment
- Visit your Railway URL
- Test registration
- Test login
- Test course creation
- Test file upload

---

## 🎯 Quick Commands Reference

```bash
# View logs
railway logs

# Run artisan commands
railway run php artisan [command]

# Clear cache
railway run php artisan cache:clear

# Run migrations
railway run php artisan migrate --force

# Open app in browser
railway open

# Check variables
railway variables
```

---

## 🔄 To Update Your App Later

```bash
# Make your changes
git add .
git commit -m "Your changes"
git push origin main

# Railway automatically rebuilds and deploys!
```

---

## 🆘 Troubleshooting

**App won't start:**
```bash
railway logs
```

**Database errors:**
```bash
railway run php artisan migrate:fresh --force
```

**Permission errors:**
```bash
railway run chmod -R 775 storage bootstrap/cache database
```

**Clear all cache:**
```bash
railway run php artisan optimize:clear
```

---

## 💰 Free Tier Limits
- $5 credit per month
- ~500 hours of usage
- 100GB outbound bandwidth
- Perfect for learning/small projects

---

## 📞 Need Help?
- Railway Docs: https://docs.railway.app
- Railway Discord: https://discord.gg/railway
- Check deployment logs in Railway Dashboard

---

**Start here: https://railway.app** 🚀
