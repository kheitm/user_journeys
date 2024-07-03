SET SQL_SAFE_UPDATES = 0;

UPDATE user_journey_data.front_interactions 

-- Use regex to replace the URLs with aliases
SET  
event_destination_url=REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(event_destination_url,'^https://365datascience.com/$','Homepage')
	    ,'https://365datascience.com/signup(?:\/.*)?$','Sign up')
        ,'https://365datascience.com/resources-center(?:\/.*)?$','Resources center')
        ,'https://365datascience.com/courses(?:\/.*)?$','Courses')
        ,'https://365datascience.com/career-tracks(?:\/.*)?$','Career tracks')
        ,'https://365datascience.com/upcoming-courses(?:\/.*)?$','Upcoming courses')
        ,'https://365datascience.com/career-track-certificate(?:\/.*)?$','Career track certificate')
        ,'https://365datascience.com/success-stories(?:\/.*)?$','Success stories')
        ,'https://365datascience.com/blog(?:\/.*)?$','Blog')
        ,'https://365datascience.com/pricing(?:\/.*)?$','Pricing')
        ,'https://365datascience.com/about-us(?:\/.*)?$','About us')
        ,'https://365datascience.com/course-certificate(?:\/.*)?$','Course certificate')
        ,'https://365datascience.com/instructors(?:\/.*)?$','Instructors')
        ,'https://365datascience.com/checkout(?:\/.*)?$','Checkout')
        ,'https://365datascience.com/login(?:\/.*)?$','Log in');

-- Use a single query to replace the remaining URLS with Other
SET  event_destination_url=REGEXP_REPLACE(event_destination_url,'https://365datascience.com(?:\/.*)?$','Other');

SET SQL_SAFE_UPDATES = 1;



