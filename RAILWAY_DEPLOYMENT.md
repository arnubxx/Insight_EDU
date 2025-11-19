# Railway Deployment Guide for Smart-Edu

## Prerequisites
- GitHub account
- Railway account (sign up at railway.app)
- Your project pushed to GitHub

## Step-by-Step Deployment

### Step 1: Install Railway CLI (Optional but Recommended)
```bash
npm install -g @railway/cli
```

### Step 2: Prepare Your Project

1. **Make sure all changes are committed:**
```bash
cd /Users/arnubdatta/Desktop/php/Smart-Edu
git add .
git commit -m "Prepare for Railway deployment"
git push origin main
```

2. **If you don't have a GitHub repo yet:**
```bash
# Initialize git (if not already done)
git init
git add .
git commit -m "Initial commit"

# Create a new repo on GitHub, then:
git remote add origin https://github.com/0xzahed/Smart-Edu.git
git branch -M main
git push -u origin main
```

### Step 3: Deploy to Railway (Web Dashboard Method)

1. **Go to Railway:**
   - Visit https://railway.app
   - Click "Start a New Project"
   - Login with GitHub

2. **Deploy from GitHub:**
   - Click "Deploy from GitHub repo"
   - Select your `Smart-Edu` repository
   - Click "Deploy Now"

3. **Railway will automatically:**
   - Detect it's a PHP/Laravel project
   - Build using the Dockerfile or Nixpacks
   - Deploy your application

### Step 4: Configure Environment Variables

In Railway Dashboard:

1. Click on your project
2. Go to "Variables" tab
3. Add these variables (click "Raw Editor"):

```env
APP_NAME=Smart Edu
APP_ENV=production
APP_DEBUG=false
APP_KEY=base64:YOUR_APP_KEY_WILL_BE_GENERATED
APP_URL=${{RAILWAY_PUBLIC_DOMAIN}}

LOG_LEVEL=error

# SQLite Configuration
DB_CONNECTION=sqlite
DB_DATABASE=/var/www/database/database.sqlite

# Session & Cache
SESSION_DRIVER=database
SESSION_LIFETIME=120
CACHE_STORE=database

# Queue
QUEUE_CONNECTION=database

# Mail Configuration (use your Gmail or SMTP)
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=your-email@gmail.com
MAIL_FROM_NAME="Smart Edu"

# Google Drive (for file uploads)
GOOGLE_DRIVE_CLIENT_ID=your_client_id
GOOGLE_DRIVE_CLIENT_SECRET=your_client_secret
GOOGLE_DRIVE_REFRESH_TOKEN=your_refresh_token
GOOGLE_DRIVE_FOLDER_ID=your_folder_id
```

### Step 5: Generate APP_KEY

**Option A - Using Railway CLI:**
```bash
railway login
railway link
railway run php artisan key:generate --show
```

Copy the generated key and add it to Railway Variables as `APP_KEY`

**Option B - Locally:**
```bash
php artisan key:generate --show
```

Copy and paste into Railway Variables

### Step 6: Enable Public Access

1. In Railway Dashboard → Settings
2. Under "Networking" → Click "Generate Domain"
3. You'll get a URL like: `smart-edu-production.up.railway.app`
4. Update `APP_URL` in Variables to this domain

### Step 7: Run Migrations

**Option A - Using Railway CLI:**
```bash
railway login
railway link
railway run php artisan migrate --force
railway run php artisan db:seed --force
```

**Option B - One-time Command in Dashboard:**
1. Go to your service
2. Click "Settings" → "Deploy"
3. Add to "Start Command":
```bash
php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=$PORT
```

### Step 8: Verify Deployment

1. Visit your Railway URL
2. Check if the app loads
3. Test login/registration
4. Check storage permissions

## Alternative: Deploy with Railway CLI

```bash
# 1. Login to Railway
railway login

# 2. Initialize project
cd /Users/arnubdatta/Desktop/php/Smart-Edu
railway init

# 3. Link to your project (if already created)
railway link

# 4. Deploy
railway up

# 5. Add variables
railway variables set APP_ENV=production
railway variables set APP_DEBUG=false
railway variables set DB_CONNECTION=sqlite
railway variables set DB_DATABASE=/var/www/database/database.sqlite

# 6. Generate APP_KEY
railway run php artisan key:generate

# 7. Run migrations
railway run php artisan migrate --force

# 8. Open in browser
railway open
```

## Using MySQL Instead of SQLite (Recommended for Production)

### Add MySQL Service:

1. In Railway Dashboard → Click "New"
2. Select "Database" → "MySQL"
3. Railway auto-creates these variables:
   - `MYSQLHOST`
   - `MYSQLPORT`
   - `MYSQLDATABASE`
   - `MYSQLUSER`
   - `MYSQLPASSWORD`

4. Update your environment variables:
```env
DB_CONNECTION=mysql
DB_HOST=${{MYSQLHOST}}
DB_PORT=${{MYSQLPORT}}
DB_DATABASE=${{MYSQLDATABASE}}
DB_USERNAME=${{MYSQLUSER}}
DB_PASSWORD=${{MYSQLPASSWORD}}
```

5. Redeploy and run migrations:
```bash
railway run php artisan migrate --force
```

## Troubleshooting

### Build Fails
- Check Railway logs
- Verify Dockerfile syntax
- Ensure all dependencies in composer.json

### Database Connection Error
- Verify DB_CONNECTION is set correctly
- Check database file permissions (SQLite)
- Ensure migrations ran successfully

### Storage Permission Issues
```bash
railway run chmod -R 775 storage bootstrap/cache
railway run php artisan storage:link
```

### Clear Cache
```bash
railway run php artisan cache:clear
railway run php artisan config:clear
railway run php artisan view:clear
```

### View Logs
```bash
railway logs
```

## Post-Deployment Checklist

- [ ] APP_KEY generated
- [ ] Database migrations completed
- [ ] Storage symlink created
- [ ] Email configuration tested
- [ ] Google Drive integration working
- [ ] SSL/HTTPS enabled (automatic on Railway)
- [ ] Environment variables set correctly
- [ ] Test user registration/login
- [ ] Test file uploads
- [ ] Test course creation
- [ ] Test assignment submission

## Updating Your App

Every time you push to GitHub:
```bash
git add .
git commit -m "Update description"
git push origin main
```

Railway will automatically:
1. Detect the push
2. Rebuild the application
3. Deploy the new version

Or manually trigger deployment:
```bash
railway up
```

## Custom Domain (Optional)

1. In Railway Dashboard → Settings → Domains
2. Click "Custom Domain"
3. Add your domain (e.g., smartedu.com)
4. Update DNS records as instructed
5. Update APP_URL in variables

## Cost Monitoring

- Free tier: $5 credit/month
- Monitor usage in Railway Dashboard
- Typical usage for small app: $3-8/month

## Support

- Railway Docs: https://docs.railway.app
- Railway Discord: https://discord.gg/railway
- GitHub Issues: Create issue in your repo

---

**You're all set! 🚀**

Your Smart-Edu LMS is now deployed on Railway!
