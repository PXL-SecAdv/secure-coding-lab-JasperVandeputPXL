# SECURE CODING

For this assignment you are going to fix one leaky boat! Our client hired a pent tester to analyze their application. The web application in question is a Flutter frontend, supported by a Node.js express backend and a Postgresql database. The client thought it would be a good idea to roll their own security. It never is. 

## The environment
Let's take a look at the files we've been given. We have access to all the source code and a docker compose file to help test the app. If you would like to test the app for yourself you can do so with the following command (if you have docker installed):

    docker compose up --build

The web app will then be available on `localhost:8080`. It is also important to note that a few shortcuts were taken to make this assignment a little easier to manipulate. Take a look at the dockerfile for the frontend, for example. You'll note that the frontend is begin built as well as being deployed. In reality, we would like the build process and the deployment to be seperate. There are also more security risks in this app than the risks shown below. The application doesn't utilize https, making it very vulnerable to man in the middle attacks, for example. We encourage you to go hunting for yourself! 

## RISK #1: SQL Injection
Our pen tester noted that it is possible to gain access to the database using SQL Injection.

&check; Use SQL Injection to gain access to the secret message. Document which command you used.

To gain access to the secret message with SQL Injection I used the following string in the `username` field: `'or 1=1--`. I also filled the `password` field with a random value as otherwise the server wouldn't accept my request.

&check; Fix the backend so user input is sanitized.

To sanitize the user input, I made use of a parameterized query.

## RISK #2: Insecure Storage
The passwords are stored in plaintext in our database. That's a big problem. The client, however, refuses to migrate to a third party solution. 

&check; Make sure the passwords in the database are encrypted.

To ensure that the passwords in the database are encrypted I hashed them with the SHA256 algorithm

&check; Make sure your solution doesn't break the login screen!

I used the sha.js npm package to hash the incoming password before comparing them to the stored passwords in the database.

## RISK #3: CORS
Our database can be queried from anywhere. We would like to avoid this by using CORS.

![task](./task.png) Research CORS. How can it help us?

CORS is a security mechanism that allows a server to specify which origins (domains) are permitted to access its resources. This helps prevent unauthorized websites from making requests to our API.
By specifying which origins are allowed and more specifically which methods and headers, we gain very granular control over how our API can be accessed.

&check; Make sure CORS is used so our backend can only be used by our frontend.

I specified that only 'http://localhost:8080' can make request with the GET method

## RISK #4: Credentials in Version Control
Right now, there are a whole lot of credentials hidden in the dockerfiles but also our backend code. These files are usually a part of our version control, making our credentials easy to track down.

&check; We don't want our credentials in our dockerfiles or our docker compose file. How can we avoid this? Our solution should not be a part of the version control system.

I added a .env file which I included in .gitignore. I then replaced the environment values with references to these in the env file. Docker will auto import a .env if it is in the same directory.

&check; Use the same solution to remove the credentials from the backend.

![task](./task.png) The damage has been done. Our credentials are exposed in an earlier commit of our version control. What would you recommend?

I would recommen changing the username to something different but still in the same way. For the passwords I recommend changing these to random generated strings of characters with a length of about 32 charactars.
