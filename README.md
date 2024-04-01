# quick_eats

A new Flutter project.

## Getting Started

### to generate hive adapter run following command
dart run build_runner build --delete-conflicting-outputs
 
### about project
1. Added authentication process with UI and mock api, from mock api it checks if user is exist or not, and if user does not exists then it tells to sign up instead of sign in. and user can create his account by entering email and password, added validations and all. And if user exists and user enters wrong password then also it tells to enter correct password. (but here for @forgot passowrd? button only tool tip has added, not other any action).

2. As per assignment points, to reduce complexity of app, I am saving user's details in JSON file in local storage by getting path while user getting authenticated. and while launching app each time i am checking user authenticated or not from this JSON file data, and then navigating user to respective screen (either login screen or home screen).

3. As per design of app from assignment, completed all UI with micro animations to optimize UX. Also added logo.

4. Each time while launching app, I am fetching restaurants list from mock api and saving in local storage with @Hive local storage mechanism. and till the data is fetching displaying some shimmer skeleton animation, and also for restaurant image, till it get renders from URL, showing shimmer animation placeholder.

5. As per assignment point, i am displaying all details on each restaurant tile like, avg rating, initial rating, number of ratings given, and option to give changing and also user can change his rating which is given in past. 

6. And i am listening all the changes from @Hive box after any interaction of user to rating and updating same on UI.

7. InAddition, also given @logout option to logout from app.

### about mock api
const kBaseUrl = "https://quick-eats.free.beeceptor.com";
// const kBaseUrl = "https://quick-eats-new.free.beeceptor.com";
// const kBaseUrl = "https://quick-eats-new-new.free.beeceptor.com";

* currently using first base url for mock api, but after finishes daily API call limit, we can use other base url as well. can switch base url from @utils.dart file in uitls directory.

### about auth users
following are some authenticated users, which are added in mock api data-
1. user1@gmail.com
2. user2@gmail.com
3. user3@gmail.com
4. user4@gmail.com
5. user5@gmail.com

*  Password is (same for all): 123456
