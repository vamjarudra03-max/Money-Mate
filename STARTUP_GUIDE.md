# MoneyMate - Startup Guide

This document explains how to start the MoneyMate project, including the Oracle Database and the GlassFish server using NetBeans IDE.

## 1. Start Oracle Database XE
Before running the application, you must ensure the Oracle Database service is running.

### Using Windows Services:
1. Press `Win + R` on your keyboard, type `services.msc`, and press **Enter**.
2. Scroll down in the Services window and look for a service named **`OracleServiceXE`**.
3. If its status is not "Running", right-click on it and select **Start**.
4. Also, ensure the **`OracleXETNSListener`** service is running. If not, right-click and select **Start**.

## 2. Open the Project in NetBeans
1. Open **NetBeans IDE 8.2** (or your installed version).
2. Go to **File** > **Open Project...** (or press `Ctrl + Shift + O`).
3. Navigate to `C:\Users\Admin\Documents\NetBeansProjects\` and select the **`MoneyMate`** folder.
4. Click **Open Project**.

## 3. Configure and Start GlassFish Server
The project uses GlassFish 4.1.1. 

1. In NetBeans, go to the **Services** tab (usually located on the left side, next to the Projects tab. If you don't see it, go to **Window** > **Services**).
2. Expand the **Servers** node.
3. You should see **GlassFish Server**. Right-click on it and select **Start**.
4. The output window at the bottom will show the server startup logs. Wait until you see a message saying the server has started successfully.

## 4. Run the Project
1. Go back to the **Projects** tab.
2. Right-click on the **MoneyMate** project folder.
3. Select **Clean and Build**. Wait for the "BUILD SUCCESSFUL" message in the Output window.
4. Right-click on the **MoneyMate** project folder again and select **Run** (or press `F6`).
5. NetBeans will deploy the application to GlassFish and automatically open your default web browser to the application's starting page (usually `http://localhost:8080/MoneyMate/` or `login.jsp`).

## 5. Testing the Application
- **Student Login:** Username: `rudra`
- **Parent Login:** Username: `parent`

## Troubleshooting
- **Database Connection Failed:** Check `src/java/com/moneymate/util/DBConnection.java` to ensure the URL, username, and password match your Oracle XE setup. Ensure Oracle services are running.
- **Port Conflict:** If GlassFish fails to start due to port `8080` being in use (Oracle XE also sometimes uses `8080`), you can change the GlassFish HTTP port in NetBeans: Right-click GlassFish under Services > Properties > Configuration > change the HTTP Port to `8081` (for example), and restart the server.
