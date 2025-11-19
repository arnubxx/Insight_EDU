# 🎯 Render.com Deployment Guide - Insight EDU

## ✅ No CLI Required - 100% Web-Based!

### **Step 1: Sign Up**
1. Go to: **https://render.com**
2. Click **"Get Started for Free"**
3. Sign up with **GitHub** (easiest)

---

### **Step 2: Create Web Service**
1. Click **"New +"** (top right)
2. Select **"Web Service"**
3. Click **"Connect GitHub"** if not connected
4. Find and select: **`arnubxx/Insight_EDU`**

---

### **Step 3: Configure Service**

**Basic Settings:**
- **Name:** `insight-edu`
- **Region:** Choose closest (Oregon, Frankfurt, Singapore)
- **Branch:** `main`
- **Root Directory:** Leave blank
- **Environment:** `Docker`
- **Instance Type:** `Free`

**Click "Advanced"** and add:

**Build Command:**
```bash
docker build -t insight-edu .
```

**Start Command:** (Leave default - uses Dockerfile CMD)

---

### **Step 4: Add Environment Variables**

Click **"Add Environment Variable"** and add these one by one:

| Key | Value |
|-----|-------|
| `APP_NAME` | `Insight EDU` |
| `APP_ENV` | `production` |
| `APP_DEBUG` | `false` |
| `APP_URL` | `https://insight-edu.onrender.com` |
| `DB_CONNECTION` | `sqlite` |
| `DB_DATABASE` | `/opt/render/project/src/storage/database/database.sqlite` |
| `SESSION_DRIVER` | `database` |
| `CACHE_STORE` | `database` |
| `QUEUE_CONNECTION` | `database` |
| `LOG_CHANNEL` | `stderr` |
| `LOG_LEVEL` | `info` |

**Leave APP_KEY blank for now** - we'll generate it after deployment.

---

### **Step 5: Deploy!**

1. Scroll down
2. Click **"Create Web Service"**
3. Wait 5-10 minutes (first build takes longer)
4. Watch the logs in the dashboard

---

### **Step 6: Generate APP_KEY**

After deployment succeeds:

1. In Render dashboard, go to your service
2. Click **"Shell"** tab (left sidebar)
3. Wait for shell to load
4. Run this command:
   ```bash
   cd /var/www/html
   php artisan key:generate --show
   ```
5. Copy the output (looks like: `base64:xxxxxxxxx`)
6. Go to **"Environment"** tab
7. Add new variable:
   - Key: `APP_KEY`
   - Value: (paste the key you copied)
8. Click **"Save Changes"**
9. App will auto-redeploy

---

### **Step 7: Run Migrations**

In the **Shell** tab, run:
```bash
cd /var/www/html
php artisan migrate --force
php artisan storage:link
```

---

### **Step 8: Test Your App!**

1. Click on the URL at top (e.g., `https://insight-edu.onrender.com`)
2. Your app should load!
3. Try registering an account
4. Test login

---

## 🔧 **Optional: Add Email & Google Drive**

### **For Email (Gmail):**

Add these environment variables:

| Key | Value |
|-----|-------|
| `MAIL_MAILER` | `smtp` |
| `MAIL_HOST` | `smtp.gmail.com` |
| `MAIL_PORT` | `587` |
| `MAIL_USERNAME` | `your-email@gmail.com` |
| `MAIL_PASSWORD` | `your-gmail-app-password` |
| `MAIL_ENCRYPTION` | `tls` |
| `MAIL_FROM_ADDRESS` | `your-email@gmail.com` |
| `MAIL_FROM_NAME` | `Insight EDU` |

**Get Gmail App Password:**
https://myaccount.google.com/apppasswords

---

### **For Google Drive (File Uploads):**

| Key | Value |
|-----|-------|
| `GOOGLE_DRIVE_CLIENT_ID` | `your_client_id` |
| `GOOGLE_DRIVE_CLIENT_SECRET` | `your_client_secret` |
| `GOOGLE_DRIVE_REFRESH_TOKEN` | `your_refresh_token` |
| `GOOGLE_DRIVE_FOLDER_ID` | `your_folder_id` |

---

## 🔄 **Auto-Deploy on Git Push**

Render automatically deploys when you push to GitHub!

```bash
git add .
git commit -m "Updates"
git push insight main
```

Render detects the push and rebuilds automatically! 🚀

---

## 📊 **Managing Your App**

### **View Logs:**
- Dashboard → Your Service → **"Logs"** tab

### **Run Commands:**
- Dashboard → Your Service → **"Shell"** tab
- Examples:
  ```bash
  php artisan cache:clear
  php artisan migrate
  php artisan db:seed
  ```

### **Restart App:**
- Dashboard → Your Service → **"Manual Deploy"** → **"Clear build cache & deploy"**

---

## 💰 **Free Tier Limits**

**Render Free Plan:**
- ✅ 750 hours/month (enough for 1 app running 24/7)
- ✅ Auto-deploys from GitHub
- ✅ Free SSL certificate
- ✅ 100GB bandwidth/month

**Note:** App spins down after 15 minutes of inactivity (free tier), first request after may take 30-60 seconds.

---

## 🆘 **Troubleshooting**

### **Build Failed:**
- Check **Logs** tab
- Look for error messages
- Common issue: Missing dependencies

### **App Won't Start:**
- Verify `APP_KEY` is set
- Check logs for errors
- Try manual deploy

### **Database Errors:**
- Make sure you ran migrations
- Check DB_DATABASE path is correct
- Run in Shell: `php artisan migrate:fresh --force`

### **500 Error:**
- Check logs
- Verify APP_KEY is set
- Clear cache: `php artisan cache:clear`

---

## 📱 **Quick Actions**

| Action | Where |
|--------|-------|
| View logs | **Logs** tab |
| Run commands | **Shell** tab |
| Update variables | **Environment** tab |
| Manual deploy | **Manual Deploy** button |
| View metrics | **Metrics** tab |

---

## 🌐 **Your App URLs**

- **Live App:** `https://insight-edu.onrender.com`
- **Dashboard:** `https://dashboard.render.com`

---

## ✅ **Checklist**

- [ ] Signed up at Render.com
- [ ] Created Web Service
- [ ] Connected Insight_EDU repo
- [ ] Set environment variables
- [ ] Deployed successfully
- [ ] Generated APP_KEY
- [ ] Ran migrations
- [ ] Tested app URL
- [ ] (Optional) Added email config
- [ ] (Optional) Added Google Drive config

---

**That's it! No terminal, no CLI - everything in the browser!** 🎉

**Start here:** https://render.com
