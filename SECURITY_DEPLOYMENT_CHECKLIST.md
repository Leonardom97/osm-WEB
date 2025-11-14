# Security Deployment Checklist

This checklist must be completed before deploying the osm-WEB application to production.

## 🚨 Critical Actions (REQUIRED)

### Database Security

- [ ] **Rotate SQL Server credentials**
  - [ ] Change password for 'sa' user on SQL Server
  - [ ] Document new password in secure password manager
  - [ ] Test connection with new credentials
  - [ ] Update all application servers

- [ ] **Rotate PostgreSQL credentials**
  - [ ] Change password for 'postgres' user on PostgreSQL
  - [ ] Document new password in secure password manager
  - [ ] Test connection with new credentials
  - [ ] Update all application servers

- [ ] **Create dedicated database users** (Recommended)
  - [ ] Create new user for application (not sa/postgres)
  - [ ] Grant minimum required permissions (SELECT, INSERT, UPDATE, DELETE on specific tables)
  - [ ] Test application with new user
  - [ ] Remove sa/postgres access from application

### Environment Configuration

- [ ] **Create production .env file**
  ```bash
  cp .env.example .env
  nano .env  # Edit with production values
  ```

- [ ] **Configure environment variables**
  ```
  DB_PG_HOST=<postgresql-host>
  DB_PG_PORT=5432
  DB_PG_NAME=osm2
  DB_PG_USER=<new-username>
  DB_PG_PASSWORD=<new-secure-password>
  
  DB_SQLSRV_HOST=<sqlserver-host>
  DB_SQLSRV_PORT=1433
  DB_SQLSRV_NAME=SVN_G4026_OSM
  DB_SQLSRV_USER=<new-username>
  DB_SQLSRV_PASSWORD=<new-secure-password>
  
  SESSION_TIMEOUT=3600
  UPLOAD_MAX_SIZE=5242880
  ENABLE_DEBUG=false  # MUST be false in production
  ```

- [ ] **Set secure file permissions**
  ```bash
  chmod 600 .env
  chmod 600 php/config.php
  chmod 755 php/
  chmod 644 php/*.php
  chmod 755 assets/
  chmod 755 logs/
  chmod 644 logs/.gitkeep
  ```

### File Upload Security

- [ ] **Verify upload directories exist**
  ```bash
  mkdir -p assets/img/uploads
  mkdir -p m_capacitaciones/assets/docs
  ```

- [ ] **Verify .htaccess files are in place**
  ```bash
  ls -la assets/img/uploads/.htaccess
  ls -la m_capacitaciones/assets/docs/.htaccess
  ```

- [ ] **Test that PHP execution is blocked in upload directories**
  - Create test.php in upload directory with `<?php echo "test"; ?>`
  - Try to access via browser - should return 403 Forbidden
  - Delete test file

### Web Server Configuration

- [ ] **Apache Configuration**
  - [ ] Verify `.htaccess` files are processed (`AllowOverride All`)
  - [ ] Disable directory listing: `Options -Indexes`
  - [ ] Hide PHP version: `expose_php = Off` in php.ini
  - [ ] Set appropriate PHP memory and upload limits

- [ ] **Nginx Configuration** (if using Nginx)
  - [ ] Configure equivalent .htaccess rules in nginx.conf
  - [ ] Block PHP execution in upload directories
  - [ ] Disable autoindex

### Logging

- [ ] **Create logs directory**
  ```bash
  mkdir -p logs
  chmod 755 logs
  touch logs/.gitkeep
  ```

- [ ] **Configure log rotation**
  ```bash
  sudo nano /etc/logrotate.d/osm-web
  ```
  ```
  /var/www/osm-WEB/logs/*.log {
      daily
      rotate 30
      compress
      delaycompress
      notifempty
      missingok
      create 0644 www-data www-data
  }
  ```

- [ ] **Test error logging**
  - Temporarily set `ENABLE_DEBUG=true`
  - Trigger an error
  - Verify error appears in `logs/php_errors.log`
  - Set `ENABLE_DEBUG=false`

## ⚠️ Important Actions (STRONGLY RECOMMENDED)

### HTTPS Configuration

- [ ] **Obtain SSL/TLS Certificate**
  - [ ] Use Let's Encrypt (free, automated renewal)
  - [ ] Or obtain commercial certificate
  - [ ] Install certificate on web server

- [ ] **Configure HTTPS**
  - [ ] Enable HTTPS in web server configuration
  - [ ] Test HTTPS access
  - [ ] Verify certificate validity

- [ ] **Enable HTTP to HTTPS redirect**
  - [ ] Configure automatic redirect
  - [ ] Test that HTTP requests redirect to HTTPS

- [ ] **Enable HSTS**
  - [ ] Edit `php/security_headers.php`
  - [ ] Uncomment HSTS header:
    ```php
    header("Strict-Transport-Security: max-age=31536000; includeSubDomains; preload");
    ```
  - [ ] Test HSTS header is present

### CSRF Protection Integration

- [ ] **Add CSRF tokens to forms**
  - [ ] Login forms
  - [ ] File upload forms
  - [ ] Data entry forms
  - [ ] Administrative forms

- [ ] **Add CSRF validation to endpoints**
  - [ ] `php/web_main_upload.php`
  - [ ] `m_capacitaciones/assets/php/file_upload_api.php`
  - [ ] All POST/PUT/DELETE endpoints

- [ ] **Add CSRF meta tag to HTML pages**
  ```html
  <?php require_once 'php/csrf_protection.php'; ?>
  <?php echo CSRFProtection::getTokenMeta(); ?>
  ```

- [ ] **Test CSRF protection**
  - [ ] Submit form without token - should fail
  - [ ] Submit form with valid token - should succeed
  - [ ] Submit form with expired token - should fail

### Database Hardening

- [ ] **Network Security**
  - [ ] Configure database firewall
  - [ ] Allow only application server IPs
  - [ ] Block public internet access

- [ ] **Audit Logging**
  - [ ] Enable database audit logging
  - [ ] Log all authentication attempts
  - [ ] Log all data modifications

- [ ] **Encryption**
  - [ ] Enable SSL/TLS for database connections
  - [ ] Update connection strings to require SSL

### Application Security

- [ ] **Session Security**
  - [ ] Verify session timeout is appropriate
  - [ ] Test concurrent session handling
  - [ ] Verify logout functionality

- [ ] **Authentication**
  - [ ] Test password reset functionality
  - [ ] Verify account lockout after failed attempts
  - [ ] Test two-factor authentication if implemented

- [ ] **Authorization**
  - [ ] Test role-based access control
  - [ ] Verify users can only access authorized resources
  - [ ] Test privilege escalation attempts (should fail)

## 📋 Recommended Actions (BEST PRACTICES)

### Monitoring & Alerting

- [ ] **Set up monitoring**
  - [ ] Application uptime monitoring
  - [ ] Error rate monitoring
  - [ ] Database connection monitoring
  - [ ] Disk space monitoring

- [ ] **Configure alerts**
  - [ ] Failed login attempts (potential brute force)
  - [ ] High error rates
  - [ ] Database connection failures
  - [ ] Disk space warnings

- [ ] **Log aggregation**
  - [ ] Set up centralized logging (ELK, Splunk, etc.)
  - [ ] Configure log retention policy
  - [ ] Set up log analysis/visualization

### Backup & Recovery

- [ ] **Database Backups**
  - [ ] Configure automated daily backups
  - [ ] Test backup restoration process
  - [ ] Store backups in secure location
  - [ ] Encrypt backup files
  - [ ] Set backup retention policy (e.g., 30 days)

- [ ] **Application Backups**
  - [ ] Backup application files
  - [ ] Backup configuration files (excluding .env)
  - [ ] Document recovery procedures

- [ ] **Disaster Recovery Plan**
  - [ ] Document recovery time objective (RTO)
  - [ ] Document recovery point objective (RPO)
  - [ ] Create runbook for common scenarios
  - [ ] Test disaster recovery procedures

### Security Testing

- [ ] **Vulnerability Scanning**
  - [ ] Run OWASP ZAP or Burp Suite
  - [ ] Address any findings
  - [ ] Document scan results

- [ ] **Manual Testing**
  - [ ] Test all authentication flows
  - [ ] Test file upload with malicious files
  - [ ] Test SQL injection attempts (should fail)
  - [ ] Test XSS attempts (should be blocked by CSP)
  - [ ] Test CSRF attacks (should fail)

- [ ] **Dependency Scanning**
  - [ ] Scan PHP dependencies for vulnerabilities
  - [ ] Scan JavaScript dependencies
  - [ ] Update vulnerable packages

### Performance & Optimization

- [ ] **PHP Configuration**
  - [ ] Set appropriate `memory_limit`
  - [ ] Set appropriate `max_execution_time`
  - [ ] Enable OPcache
  - [ ] Configure session garbage collection

- [ ] **Database Optimization**
  - [ ] Verify indexes are in place
  - [ ] Analyze slow queries
  - [ ] Configure connection pooling
  - [ ] Set appropriate cache settings

- [ ] **Web Server Optimization**
  - [ ] Enable gzip compression
  - [ ] Configure browser caching
  - [ ] Optimize static file delivery
  - [ ] Consider CDN for static assets

### Documentation

- [ ] **Update Documentation**
  - [ ] Document deployment procedure
  - [ ] Document backup/recovery procedure
  - [ ] Document security incident response plan
  - [ ] Document escalation procedures

- [ ] **Create Runbooks**
  - [ ] Database connection issues
  - [ ] Application errors
  - [ ] Performance issues
  - [ ] Security incidents

## 🔍 Final Verification

### Pre-Launch Checks

- [ ] **Security Headers**
  ```bash
  curl -I https://your-domain.com | grep -i "x-frame\|x-content\|x-xss\|referrer\|content-security"
  ```
  - Verify all security headers are present

- [ ] **SSL/TLS Configuration**
  - [ ] Test at https://www.ssllabs.com/ssltest/
  - [ ] Aim for A or A+ rating

- [ ] **Configuration Review**
  - [ ] Verify `ENABLE_DEBUG=false` in .env
  - [ ] Verify error display is off
  - [ ] Verify production credentials are in place
  - [ ] Verify .env file is not web-accessible

- [ ] **File Permissions**
  ```bash
  # Verify permissions
  ls -la .env  # Should be 600
  ls -la php/*.php  # Should be 644
  ls -la logs/  # Should be 755
  ```

- [ ] **Upload Security**
  - [ ] Test uploading PHP file - should be rejected
  - [ ] Test uploading image with PHP content - should be rejected
  - [ ] Test uploading valid image - should succeed
  - [ ] Verify uploaded file is not executable

### Smoke Testing

- [ ] **Functionality Test**
  - [ ] Test user login
  - [ ] Test file upload
  - [ ] Test data entry forms
  - [ ] Test data retrieval
  - [ ] Test logout

- [ ] **Error Handling**
  - [ ] Trigger an error
  - [ ] Verify user sees generic error message
  - [ ] Verify detailed error is logged
  - [ ] Verify no sensitive information is exposed

- [ ] **Performance Test**
  - [ ] Test application under normal load
  - [ ] Verify response times are acceptable
  - [ ] Check for memory leaks

## 📞 Post-Deployment

### First 24 Hours

- [ ] Monitor application logs continuously
- [ ] Monitor error logs
- [ ] Monitor database performance
- [ ] Monitor server resources (CPU, memory, disk)
- [ ] Verify backups are running

### First Week

- [ ] Review access logs for suspicious activity
- [ ] Review error logs for issues
- [ ] Verify monitoring and alerting is working
- [ ] Collect performance metrics
- [ ] Gather user feedback

### Ongoing Maintenance

- [ ] Weekly log review
- [ ] Monthly security updates
- [ ] Quarterly security audits
- [ ] Annual penetration testing
- [ ] Keep dependencies updated

## 🆘 Emergency Contacts

Document emergency contacts and escalation procedures:

```
Security Incident: [Contact Name] - [Phone] - [Email]
Database Issues: [Contact Name] - [Phone] - [Email]
Infrastructure: [Contact Name] - [Phone] - [Email]
Application Support: [Contact Name] - [Phone] - [Email]
```

## ✅ Sign-Off

```
Deployment Date: _______________
Deployed By: _______________
Reviewed By: _______________
Security Approved By: _______________

Notes:
_________________________________
_________________________________
_________________________________
```

---

**Remember:** This checklist is a starting point. Adapt it to your specific environment, security requirements, and compliance needs.

For questions or issues, refer to:
- SECURITY_AUDIT_REPORT.md - Complete security audit findings
- .env.example - Configuration template
- php/security_headers.php - Security header configuration
- php/csrf_protection.php - CSRF protection usage
