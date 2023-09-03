
title: Meet Chavan - GDSC DJSCE - App Task
created at: Sun Sep 03 2023 16:50:20 GMT+0000 (Coordinated Universal Time)
updated at: Sun Sep 03 2023 16:50:39 GMT+0000 (Coordinated Universal Time)
---

# Meet Chavan - GDSC DJSCE - App Task

This app was developed as a part of Task for Google Developer Student Club - Dwarkadas J. Sanghvi College of Engineering

The app constitutes of 4 modules/screens.

![gdscapp.png](media_Meet%20Chavan%20-%20GDSC%20DJSCE%20-%20App%20Task/gdscapp.png)

1.  Splash Screen

    The Splash Screen module which contains an animated logo of GDSC checks for the status of Firebase Authentication and redirects the user to either Registration or Home based on his status of login.

2.  Registration

    The registration module contains Name, Email and Password field having a visibility toggle, which on clicking register creates a user into Firebase Auth and redirects the user to Home Screen if success. The module also contains an option to switch to login screen if user is already registered.

3.  Login

    The login module contains Email and Password field having a visibility toggle, which on clicking login validates the user in Firebase Auth and redirects the user to Home Screen if success. The module contains a 'Forgot Password' option which sends the password reset email to the user. The module also contains an option to switch to Register screen if user wants to create a new account.

4.  Home Screen

    The Home module displays the signed in users information into a card which shows name, email as well as profile picture. The profile picture can be updated by clicking on the profile picture which opens a File Picker. This newly picked image is then uploaded to Firebase Storage and the photoURL of user is updated.

          