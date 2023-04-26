# Address Book

## Rails Quiz

This application has a few issues and features.  Please solve the required fix, and then choose three other stories/issues (or solve the issues you were asked to solve), opening a pull request for each issue you've chosen to solve.
Please make your solutions to this application as if you're doing your every day work.  Shoot for 100% coverage (Will require fixing PersonController)

### Required fix
DONE 1. As a front-end user, when creating a new Person entry, I want the value I enter into the phone number field to be saved to my new entry. (See failing specs)

### Performance Issues
2. Too many queries to the database, load Companies along with People.
3. As a front-end user, when viewing more than 10 entries in the index, I will see them paginated (with Kaminari).

### Issue User Stories
4. As a front-end user, when creating a new Person entry, when the new entry is unable to be saved, I will see a message with the error, and it will keep the values in the fields I have already filled out. 

### Feature User Stories
5. As a front-end user, I want to be able to list companies, create a new company and edit companies
6. As a front-end user, when creating a new Person entry, I would like to be able to select an existing company
7. As a front-end user I want to be able to assign multiple companies to a single person, and multiple people to the same company.
8. As a front-end user I want to make sure that the email I have entered is correct by entering it twice in the form
9. As an administrator of this system, I want to know that the email addresses going in to the system are valid email addresses

### API Endpoints
10. Create an API endpoint that exposes People to the public with filtering based on email, and pagination.
Example GET request:
`{ email: 'foo@bar.baz', page: 1, per_page: 10 }`

11. Create an API endpoint that exposes Companies to the public with filtering based on case insensitive partial matches to company name with pagination.
Example GET request: 
`{ name: 'digital', page: 1, per_page: 10 }`

12. Create an API endpoint that exposes Company creation via JSON with basic authentication allowing for the creation of multiple companies.  It should return a response with company objects including their newly created IDs
Example POST request:
`{ companies: [{ name: 'Foo Bar, Inc' }, ...] }`
