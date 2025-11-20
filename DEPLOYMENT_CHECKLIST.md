# 🔍 RENDER DEPLOYMENT CHECKLIST - CRITICAL

## ✅ VERIFIED WORKING LOCALLY

1. **✅ Database:** SQLite working, migrations successful
2. **✅ Registration Page:** Renders correctly with role cards
3. **✅ Placeholders:** Shows "Arnub" and "Datta"
4. **✅ JavaScript:** Role selection code compiled and present in `auth-Bs-9Ph-n.js`
5. **✅ HTML Structure:** `data-role="student"` and `data-role="instructor"` present

---

## 🚨 CRITICAL: RENDER ENVIRONMENT VARIABLES

**These MUST be set in Render Dashboard → Environment:**

### **Required Variables:**
```
APP_NAME=Insight EDU
APP_ENV=production
APP_DEBUG=false
APP_KEY=(generate after first deploy)
APP_URL=https://your-app-name.onrender.com
DB_CONNECTION=sqlite
DB_DATABASE=/var/www/html/storage/database/database.sqlite
SESSION_DRIVER=database
CACHE_STORE=database
QUEUE_CONNECTION=database
LOG_CHANNEL=stderr
LOG_LEVEL=info
```

### **After First Deploy - Generate APP_KEY:**
1. Go to Render Dashboard → Shell
2. Run: `cd /var/www/html && php artisan key:generate --show`
3. Copy the output (e.g., `base64:xxxxx`)
4. Add to Environment variables
5. Save (triggers auto-redeploy)

---

## 📋 POST-DEPLOYMENT STEPS

### **1. Run Migrations (Shell Tab):**
```bash
cd /var/www/html
php artisan migrate --force
php artisan storage:link
php artisan cache:clear
```

### **2. Test Registration:**
- Open your Render URL
- Go to `/register`
- **Click on Student or Instructor role card**
- **Verify the card gets highlighted/selected**
- Fill form with test data
- Submit

### **3. Check Browser Console:**
- Open Developer Tools (F12)
- Go to Console tab
- Look for ANY JavaScript errors
- **Specifically check if role selection works**

---

## 🐛 IF ROLE SELECTION STILL DOESN'T WORK:

### **Debug Steps:**

1. **Check if JavaScript is loaded:**
   - View page source
   - Search for `/build/assets/auth-`
   - Verify the file loads (no 404)

2. **Verify HTML structure:**
   - View page source
   - Search for `data-role="`
   - Should find two: `data-role="student"` and `data-role="instructor"`

3. **Check Browser Console for errors:**
   - Any errors about undefined variables?
   - Any errors about `querySelector`?

4. **Test manually in console:**
   ```javascript
   // Open browser console and run:
   document.querySelectorAll('.role-card').length
   // Should return 2
   
   document.getElementById('selectedRole')
   // Should not be null
   ```

---

## 🔧 KNOWN WORKING CODE

The registration functionality is in `/resources/js/pages/auth.js`:

```javascript
if (isRegistrationPage) {
    const roleCards = document.querySelectorAll('.role-card');
    const selectedRoleInput = document.getElementById('selectedRole');
    
    roleCards.forEach(card => {
        card.addEventListener('click', function() {
            roleCards.forEach(c => c.classList.remove('selected'));
            this.classList.add('selected');
            const role = this.getAttribute('data-role');
            selectedRoleInput.value = role;
            // ... rest of the code
        });
    });
}
```

This code IS compiled and present in the built assets.

---

## 🎯 VERIFICATION CHECKLIST

After deployment, verify:

- [ ] App loads without 500 error
- [ ] Registration page renders
- [ ] Placeholders show "Arnub" and "Datta"
- [ ] Two role cards are visible (Student & Instructor)
- [ ] Clicking Student card highlights it
- [ ] Clicking Instructor card highlights it
- [ ] Form submission works
- [ ] No JavaScript errors in console

---

## 📞 IF STILL NOT WORKING

1. Check Render **Logs** tab for any errors
2. Verify ALL environment variables are set correctly
3. Try **Clear build cache & deploy**
4. Check if `npm run build` ran successfully in build logs
5. Verify the correct repository is connected: `arnubxx/Insight_EDU`

---

## 🚀 READY TO DEPLOY

All code is pushed to: `https://github.com/arnubxx/Insight_EDU.git`

Latest commit includes:
- ✅ Role selection fix (removed duplicate listeners)
- ✅ Placeholder updates (Arnub & Datta)
- ✅ Database fixes (SQLite)
- ✅ Compiled assets

**Deploy from Render Dashboard or it will auto-deploy on next push!**
