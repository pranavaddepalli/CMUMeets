
# CMUMeets
67443 Project Repository


### A note about code coverage
Our tests attempted to cover as much logic as we could in our non-view files, but this proved to be difficult for our Firebase controller. As all of the calls made from the controller connect to the Firestore database, there is a delay in receiving the information. This means that in order to write effective tests for these functions, they need to execute after the calls are completed by the Firebase controller. However, to implement this, it required us to make our controller functions asynchronous, so that we could use the `await` keyword, but this was not possible as the functions are used in other contexts that don't allow this (i.e., a MakeUIView function for MapKit that disallows asynchronous calls). We could also implement a way to manually track if data was received such as using the built-in semaphore tools, but this would be both resource wasteful and ambiguous as we don't know for sure when data is done being transferred.

As a result, we had to leave our Firebase controller alone. The consequence of this is that the results of the tests for Firebase may not seem accurate:
- Sometimes, they do not complete executing as a task is created during another session (i.e., a test begins before another expectation is fulfilled)
- Sometimes, the tests finish execution with high coverage, as the Firebase calls finish executing (highest coverage seen so far: 88%)

However, for the majority of test cases in the FirebaseTests file, the logic is correct. 

Example results (unchanged code):

- Case 1: "task created in a session that has been invalidated" error
<img width="2291" alt="image" src="https://user-images.githubusercontent.com/46876327/207790880-9ca040d0-6f67-4630-b9c5-a9fcd3a792cb.png">

- Case 2: High coverage success
<img width="1288" alt="image" src="https://user-images.githubusercontent.com/46876327/207791344-4693aa20-5736-4f59-b232-411da5f71d8d.png">
