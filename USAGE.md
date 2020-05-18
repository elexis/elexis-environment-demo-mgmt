# How to use the demo environment

Browse to https://yourinstance.elexisdemo.ch:9000/hooks/form 

To adapt and start an elexis-environment demo instance, perform the following steps:

1. In `Reconfigure/Reset this instance` fill out the required values and click `!!! Update.env ...`. This will set all required values and rebot the server.
   1. You will see the `ADMIN_PASSWORD` be shown on the browser. Take note of it, it will not be shown again.
   2. Wait for a minute, the server is rebooting now.
   3. Go back to the form.
2. Execute `Configure EE` to check EE configuration. If everything is ok (see the browser output), you can go on to start the EE.
3. Execute `Startup EE ...` to start EE. This may take a while, as all images are pulled etc. (which is not visible in the browser).
4. Check the status with `EE status` 

After startup the EE should be ready for usage. Try by browsing http://yourinstance.elexisdemo.ch 