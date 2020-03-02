# My Humble Bundle App

The current Humble Bundle App is slow, annoying and missing a lot of features. I always wanted to write an Android app, so this will be it. I will use this opportunity to also start learning Kotlin, because why not.

I have never written a real app, and never used Kotlin, so this is going to be interesting...

## General Idea

Starting the app for the first time will show an interface to enter credentials. After entering, the app will sync the purchased bundles. I will sync all bundles. The available bundles will be presented on an overview, Selecting a bundle will show a new intent that lists the available bundle parts. Tapping an item will show more information for that item and a download button. Alternatively you can directly tap a download button on the item overview intent.

There will be a search button on all intents that will search through all purchased bundles and present hits in a drop-down menu where the item can be selected.

Downloads will be queued and processed FIFO. Downloads happen in the background. There will be a download manager intent where you can reorder the queue.

## Resources

[Hayden Schiff](https://www.schiff.io/projects/humble-bundle-api) has reversed the API that is used by the original app.


tags: programming kotlin android
